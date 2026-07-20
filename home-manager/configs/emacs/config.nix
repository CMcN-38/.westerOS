{pkgs, ...}: {
  # Symlink static emacs config files into ~/.config/emacs
  # bookmarks is intentionally omitted — emacs manages it at runtime
  home.file = {
    ".config/emacs/config.org".source = ./configs/config.org;
    ".config/emacs/early-init.el".source = ./configs/early-init.el;
    ".config/emacs/init.el".source = ./configs/init.el;
    ".config/emacs/scripts".source = ./configs/scripts;
    ".config/emacs/assets".source = ./configs/assets;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacs;
    client.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "emacsclient -t";
    VISUAL = "emacsclient -c";
  };

  programs.zsh.shellAliases = {
    e = "emacsclient -t";
    ec = "emacsclient -c";
    emacs-debug = "emacs --debug-init";
  };

  # Hide the plain emacs desktop entry — emacsclient is used instead
  xdg.desktopEntries.emacs = {
    name = "Emacs";
    noDisplay = true;
  };
}
