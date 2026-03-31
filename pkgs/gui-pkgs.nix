#
#b.             8  8 8888 `8.`8888.      ,8'  ,o888888o.       d888888o.
#888o.          8  8 8888  `8.`8888.    ,8'. 8888     `88.   .`8888:' `88.
#Y88888o.       8  8 8888   `8.`8888.  ,8',8 8888       `8b  8.`8888.   Y8
#.`Y888888o.    8  8 8888    `8.`8888.,8' 88 8888        `8b `8.`8888.
#8o. `Y888888o. 8  8 8888     `8.`88888'  88 8888         88  `8.`8888.
#8`Y8o. `Y88888o8  8 8888     .88.`8888.  88 8888         88   `8.`8888.
##8   `Y8o. `Y8888  8 8888    .8'`8.`8888. 88 8888        ,8P    `8.`8888.
##8      `Y8o. `Y8  8 8888   .8'  `8.`8888.`8 8888       ,8P 8b   `8.`8888.
##8         `Y8o.`  8 8888  .8'    `8.`8888.` 8888     ,88'  `8b.  ;8.`8888
##8            `Yo  8 8888 .8'      `8.`8888.  `8888888P'     `Y8888P ,88P'
#
#
# ██████╗ ██╗   ██╗██╗    ██████╗  █████╗  ██████╗██╗  ██╗ █████╗  ██████╗ ███████╗███████╗
#██╔════╝ ██║   ██║██║    ██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔══██╗██╔════╝ ██╔════╝██╔════╝
#██║  ███╗██║   ██║██║    ██████╔╝███████║██║     █████╔╝ ███████║██║  ███╗█████╗  ███████╗
#██║   ██║██║   ██║██║    ██╔═══╝ ██╔══██║██║     ██╔═██╗ ██╔══██║██║   ██║██╔══╝  ╚════██║
#╚██████╔╝╚██████╔╝██║    ██║     ██║  ██║╚██████╗██║  ██╗██║  ██║╚██████╔╝███████╗███████║
# ╚═════╝  ╚═════╝ ╚═╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝
#
{pkgs,
inputs,
...}: let
  pkgsTx = import inputs.nixpkgs_tx {
    inherit (pkgs) system;
    # If you use unfree anywhere, keep this consistent:
    config.allowUnfree = true;
  };
in {
  #            ┓
  #┏┓┏┓┏┓┏┓┏┓┏┓┃
  #┗┫┗ ┛┗┗ ┛ ┗┻┗
  # ┛

  environment.systemPackages = with pkgs; [
    pkgsTx.transmission_4-gtk
    # GUI packages below
    blender                     # 3d rendering
    # calibre                     # e-book manager
    discord-ptb                     # discord
    # betterdiscordctl
    # discord-canary
    evince                      # document viewer
    # google-chrome
    firefox
    goxlr-utility               # goxlr controller
    imv                         # image viewer
    kitty                       # terminal
    keymapp                     # keyboard mapping
    localsend                   # local file sending
    mpv                         # multimedia player
    obsidian                    # pkm notes
    obs-studio                  # screen recording
    proton-pass                 # password manager
    syncthing                   # file sync
    thonny                      # pi-zero IDE
    # transmission_4-gtk          # torrent interface
    zotero                      # document manager (replacing with paperless)
  ];

  services.goxlr-utility.enable = true;
  programs.steam.enable = true; 
}
