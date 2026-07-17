
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
#███████╗███████╗██████╗ ██╗   ██╗██╗ ██████╗███████╗    ██████╗  █████╗  ██████╗██╗  ██╗ █████╗  ██████╗ ███████╗███████╗
#██╔════╝██╔════╝██╔══██╗██║   ██║██║██╔════╝██╔════╝    ██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔══██╗██╔════╝ ██╔════╝██╔════╝
#███████╗█████╗  ██████╔╝██║   ██║██║██║     █████╗      ██████╔╝███████║██║     █████╔╝ ███████║██║  ███╗█████╗  ███████╗
#╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║     ██╔══╝      ██╔═══╝ ██╔══██║██║     ██╔═██╗ ██╔══██║██║   ██║██╔══╝  ╚════██║
#███████║███████╗██║  ██║ ╚████╔╝ ██║╚██████╗███████╗    ██║     ██║  ██║╚██████╗██║  ██╗██║  ██║╚██████╔╝███████╗███████║
#╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝ ╚═════╝╚══════╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝
#
{pkgs, ...}: {
  #            ┓
  #┏┓┏┓┏┓┏┓┏┓┏┓┃
  #┗┫┗ ┛┗┗ ┛ ┗┻┗
  # ┛

  environment.systemPackages = with pkgs; [
    appimage-run
    apprun-cli
    bc
    brightnessctl
    # cargo
    clang_18
    cmake
    ddcutil
    espanso-wayland
    gccgo13
    gtk4
    glib
    go
    imagemagick
    imagemagickBig
    jq
    lua
    libnotify
    libxcb
    mosh
    # networkmanagerapplet
    nodejs_22
    openssl.dev
    pkg-config
    poppler-utils
    pamixer
    playerctl

    (python3.withPackages (ps:
      with ps; [
        requests
        jedi-language-server
        pip
        scipy
        wand
      ]))
    # rustup
    libsForQt5.qt5.qtwayland
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtsvg
    libsForQt5.qt5.qtquickcontrols
    libadwaita
    # rustc
    rustup
    tesseract4
    tree-sitter
    uwsm

    wireguard-tools
    wgnord
    wl-clipboard
    zig
    zsa-udev-rules

    # Emacs tools — LSP servers, formatters, and runtime dependencies
    nil                                          # Nix LSP
    rust-analyzer                                # Rust LSP
    nodePackages.typescript-language-server      # TS/JS LSP
    nodePackages.yaml-language-server            # YAML LSP
    nodePackages.vscode-langservers-extracted    # HTML/CSS/JSON LSP
    nodePackages.prettier                        # Multi-language formatter
    black                                        # Python formatter
    sqlite                                       # org-roam database
    graphviz                                     # org-mode diagram rendering
    pandoc                                       # document conversion
    gnumake                                      # vterm native module build
    libtool                                      # vterm native module build
  ];

  programs.streamdeck-ui = {
    enable = true;
    autoStart = true; # optional
  };


    services.upower = {
        enable = true;
    };
}
