#
#b.             8  8 8888 `8.`8888.      ,8'  ,o888888o.       d888888o.
#888o.          8  8 8888  `8.`8888.    ,8'. 8888     `88.   .`8888:' `88.
#Y88888o.       8  8 8888   `8.`8888.  ,8',8 8888       `8b  8.`8888.   Y8
#.`Y888888o.    8  8 8888    `8.`8888.,8' 88 8888        `8b `8.`8888.
#8o. `Y888888o. 8  8 8888     `8.`88888'  88 8888         88  `8.`8888.
#8`Y8o. `Y88888o8  8 8888     .88.`8888.  88 8888         88   `8.`8888.
#8   `Y8o. `Y8888  8 8888    .8'`8.`8888. 88 8888        ,8P    `8.`8888.
#8      `Y8o. `Y8  8 8888   .8'  `8.`8888.`8 8888       ,8P 8b   `8.`8888.
#8         `Y8o.`  8 8888  .8'    `8.`8888.` 8888     ,88'  `8b.  ;8.`8888
#8            `Yo  8 8888 .8'      `8.`8888.  `8888888P'     `Y8888P ,88P'
#
#
# ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ ██╗   ██╗██████╗  █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
#██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ ██║   ██║██╔══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
#██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗██║   ██║██████╔╝███████║   ██║   ██║██║   ██║██╔██╗ ██║
#██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║██║   ██║██╔══██╗██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
#╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝╚██████╔╝██║  ██║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
# ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
#
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
#•
#┓┏┳┓┏┓┏┓┏┓╋┏
#┗┛┗┗┣┛┗┛┛ ┗┛
#    ┛

    imports = [
        # Include the results of the hardware scan.
        ./hardware-configuration.nix
        inputs.home-manager.nixosModules.default

        # Packages:
        ../../pkgs/gui-pkgs.nix
        ../../pkgs/serv-pkgs.nix
        ../../pkgs/term-pkgs.nix
        ../../pkgs/wm-pkgs.nix
        ../../pkgs/fonts.nix


        # Modules:
        ../../modules/networking-baratheon.nix
        ../../modules/users.nix
        ../../modules/devices-baratheon.nix
        ../../modules/settings.nix
        ../../modules/style.nix
    ];

    # Packages to enable yubikey use
    # environment.systemPackages = with pkgs; [
    #     yubikey-manager
    #     pam_u2f
    #     libfido2
    # ];

    # Packages to enable fingerprint
    services.fwupd.enable = true;
    services.fprintd.enable = true;
    # services.fprintd.tod.enable = true;

    console = {
        keyMap = "dvorak";
    };

    # Yubikey Setup for sudo
#     services.pcscd.enable = true;
    security.polkit.enable = true;
    security.pam.services = {
        sudo.fprintAuth = true;
        sudo.unixAuth = true;
        login.fprintAuth = true;
        login.unixAuth = true;
        sddm.fprintAuth = true;
    };

    # Battery Saver Mode - Sudo permissions
    security.sudo.extraRules = [
        # {
        #     users = [ "cameron" ];
        #     commands = [
        #         {
        #             command = "/run/current-system/sw/bin/tee /sys/class/leds/chromeos::kbd_backlight/brightness";
        #             options = [ "NOPASSWD" ];
        #         }
        #     ];
        # }
        {
            users = [ "cameron" ];
            commands = [
                {
                    command = "/run/current-system/sw/bin/tee /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq";
                    options = [ "NOPASSWD" ];
                }
            ];
        }
    ];
    #
}







