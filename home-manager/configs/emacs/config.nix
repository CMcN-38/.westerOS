#                                     .x+=:.        s                                    ....                ...
#      x=~                           z`    ^%      :8                                .x~X88888Hx.        .x888888hx    :
#     88x.   .e.   .e.                  .   <k    .88                  .u    .      H8X 888888888h.     d88888888888hxx
#    '8888X.x888:.x888       .u       .@8Ned8"   :888ooo      .u     .d88B :@8c    8888:`*888888888:   8" ... `"*8888%`
#     `8888  888X '888k   ud8888.   .@^%8888"  -*8888888   ud8888.  ="8888f8888r   88888:        `%8  !  "   ` .xnxx.
#      X888  888X  888X :888'8888. x88:  `)8b.   8888    :888'8888.   4888>'88"  . `88888          ?> X X   .H8888888%:
#      X888  888X  888X d888 '88%" 8888N=*8888   8888    d888 '88%"   4888> '    `. ?888%           X X 'hn8888888*"   >
#      X888  888X  888X 8888.+"     %8"    R88   8888    8888.+"      4888>        ~*??.            > X: `*88888%`     !
#     .X888  888X. 888~ 8888L        @8Wou 9%   .8888Lu= 8888L       .d888L .+    .x88888h.        <  '8h.. ``     ..x8>
#     `%88%``"*888Y"    '8888c. .+ .888888P`    ^%888*   '8888c. .+  ^"8888*"    :"""8888888x..  .x    `88888888888888f
#       `~     `"        "88888%   `   ^"F        'Y"     "88888%       "Y"      `    `*888888888"      '%8888888888*"
#                          "YP'                             "YP'                         ""***""           ^"****""`
#
#    888
#    888
#    888
#    88888b.   .d88b.  88888b.d88b.   .d88b.         88888b.d88b.   8888b.  88888b.   8888b.   .d88b.   .d88b.  888d888
#    888 "88b d88""88b 888 "888 "88b d8P  Y8b        888 "888 "88b     "88b 888 "88b     "88b d88P"88b d8P  Y8b 888P"
#    888  888 888  888 888  888  888 88888888 888888 888  888  888 .d888888 888  888 .d888888 888  888 88888888 888
#    888  888 Y88..88P 888  888  888 Y8b.            888  888  888 888  888 888  888 888  888 Y88b 888 Y8b.     888
#    888  888  "Y88P"  888  888  888  "Y8888         888  888  888 "Y888888 888  888 "Y888888  "Y88888  "Y8888  888
#                                                                                                  888
#                                                                                             Y8b d88P
#                                                                                              "Y88P"
{
  pkgs,
  config,
  lib,
  ...
}: {
#    ▗▄▄▄▖▗▖  ▗▖ ▗▄▖  ▗▄▄▖ ▗▄▄▖
#    ▐▌   ▐▛▚▞▜▌▐▌ ▐▌▐▌   ▐▌
#    ▐▛▀▀▘▐▌  ▐▌▐▛▀▜▌▐▌    ▝▀▚▖
#    ▐▙▄▄▖▐▌  ▐▌▐▌ ▐▌▝▚▄▄▖▗▄▄▞▘
#

  # Link Doom configuration files to ~/.doom.d/
  home.file.".doom.d" = {
    source = ./doom;
    recursive = true;
    onChange = ''
      # Only sync if doom binary exists
      if [ -x "${config.home.homeDirectory}/.config/emacs/bin/doom" ]; then
        echo "Syncing Doom Emacs configuration..."
        ${config.home.homeDirectory}/.config/emacs/bin/doom sync
      fi
    '';
  };

  # Emacs itself is managed via programs.emacs for better integration
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;  # Use the version from term-pkgs.nix
    extraPackages = epkgs: [
      # Only add packages that are truly required before Doom setup
      # Most packages will be managed by Doom itself via straight.el
    ];
  };

  # Essential CLI tools that Doom expects
  home.packages = with pkgs; [
    # Core dependencies (many already in term-pkgs.nix, but listed for clarity)
    git         # Required by Doom
    ripgrep     # Used by many Doom modules for searching
    fd          # Fast file finder used by Doom

    # LSP servers (add more as needed)
    nil         # Nix LSP
    rust-analyzer  # Rust LSP
    # nodePackages.pyright  # Python LSP
    nodePackages.typescript-language-server  # TS/JS LSP
    nodePackages.yaml-language-server
    nodePackages.vscode-langservers-extracted  # HTML/CSS/JSON LSP

    # Formatters
    nixpkgs-fmt    # Nix formatter (or use 'alejandra')
    nodePackages.prettier  # Multi-language formatter
    black          # Python formatter
    rustfmt        # Rust formatter

    # Additional tools
    sqlite         # Required for org-roam if enabled
    graphviz       # For org-mode diagrams
    pandoc         # Document conversion

    # Markdown preview (if using +grip in markdown module)
    # grip  # Uncomment if you want GitHub-flavored markdown preview
  ];

  # Activation script to set up Doom on first install
  home.activation.installDoomEmacs = lib.hm.dag.entryAfter ["writeBoundary"] ''
    DOOM_DIR="${config.home.homeDirectory}/.config/emacs"
    DOOM_BIN="$DOOM_DIR/bin/doom"

    if [ ! -d "$DOOM_DIR" ]; then
      $DRY_RUN_CMD echo "Installing Doom Emacs..."
      $DRY_RUN_CMD ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs "$DOOM_DIR"
      $DRY_RUN_CMD "$DOOM_BIN" install --no-env --no-fonts
    else
      # Doom already installed, just sync if binary exists
      if [ -x "$DOOM_BIN" ]; then
        $DRY_RUN_CMD echo "Updating Doom Emacs..."
        $DRY_RUN_CMD "$DOOM_BIN" sync -u
      fi
    fi
  '';

  # Optional: Set environment variables
  home.sessionVariables = {
    EDITOR = "emacsclient -t";
    VISUAL = "emacsclient -c";
  };

  # Optional: Shell aliases for convenient Emacs usage
  programs.zsh.shellAliases = {
    e = "emacsclient -t";
    ec = "emacsclient -c";
    emacs-debug = "emacs --debug-init";
  };
}
