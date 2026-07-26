{ config, pkgs, secrets, ... }:
let
  emailCfg = secrets.email or {};
  address  = emailCfg.address  or "user@proton.me";
  realName = emailCfg.realName or "User";
in {

  # ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  # ┃  ProtonMail Bridge — headless IMAP/SMTP local proxy  ┃
  # ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  #
  # First-time setup (one-off, interactive):
  #   1. protonmail-bridge --cli
  #   2. login    (follow prompts to authenticate)
  #   3. info     (note the bridge "Password:" — NOT your account password)
  #   4. exit
  #   5. install -m600 /dev/null ~/.config/protonmail/bridge-pass
  #      printf 'YOUR_BRIDGE_PASSWORD' > ~/.config/protonmail/bridge-pass
  #   6. mu init --maildir=~/Mail --my-address=<your address>
  #      mbsync -a && mu index

  systemd.user.services.protonmail-bridge = {
    Unit = {
      Description = "ProtonMail Bridge";
      After = [ "network.target" ];
    };
    Service = {
      ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --noninteractive";
      Restart = "on-failure";
      RestartSec = "5s";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  # ┃  Mail account — ProtonMail      ┃
  # ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  accounts.email = {
    maildirBasePath = "${config.home.homeDirectory}/Mail";

    accounts.protonmail = {
      primary  = true;
      inherit address realName;

      imap = {
        host = "127.0.0.1";
        port = 1143;
        tls = {
          enable = true;
          useStartTls = true;
          # Generated on first bridge login
          certificatesFile = "${config.home.homeDirectory}/.local/share/protonmail/bridge-v3/cert.pem";
        };
      };

      smtp = {
        host = "127.0.0.1";
        port = 1025;
        tls.enable = false;
      };

      # Bridge-generated password stored at ~/.config/protonmail/bridge-pass (chmod 600)
      passwordCommand = "cat ${config.home.homeDirectory}/.config/protonmail/bridge-pass";

      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
        patterns = [ "*" "!Labels/*" ];
      };

      msmtp.enable = true;
    };
  };

  programs.mbsync.enable = true;
  programs.msmtp.enable = true;

  # ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  # ┃  Auto-sync every 5 minutes, then re-index  ┃
  # ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  services.mbsync = {
    enable = true;
    frequency = "*:0/5";
    postExec = "${pkgs.mu}/bin/mu index";
  };
}
