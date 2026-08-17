{config, pkgs, ...}: {
  imports = [
    ./btop/config.nix
    ./kitty/config.nix
    ./rofi/config.nix
    ./starship/config.nix
    ./swaync/config.nix
    ./swayosd/config.nix
    ./tmux/config.nix
    ./waybar/config.nix
    ./nvim/default.nix
    ./emacs/config.nix
  ];

  home.username = "cameron";
  home.homeDirectory = "/home/cameron";

  home.stateVersion = "26.05"; # Please read the comment before changing.

  programs.home-manager.enable = true;

  qt.enable = true;

  services.syncthing.enable = true;

  # Zen Browser desktop entry
  xdg.desktopEntries.zen-browser = {
    name = "Zen Browser";
    genericName = "Web Browser";
    exec = "appimage-run -d ${config.home.homeDirectory}/2_desktop/zen-specific.AppImage %U";
    terminal = false;
    categories = [ "Application" "Network" "WebBrowser" ];
    mimeType = [ "text/html" "text/xml" "application/xhtml+xml" "x-scheme-handler/http" "x-scheme-handler/https" ];
  };

  # Set Zen as default browser
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen-browser.desktop";
      "x-scheme-handler/http" = "zen-browser.desktop";
      "x-scheme-handler/https" = "zen-browser.desktop";
      "x-scheme-handler/about" = "zen-browser.desktop";
      "x-scheme-handler/unknown" = "zen-browser.desktop";
    };
  };
}
