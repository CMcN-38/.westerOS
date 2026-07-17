{
  pkgs,
  config,
  lib,
  ...
}: {
  # Copy emacs configuration files to ~/.config/emacs on each rebuild
  home.activation.copyEmacsConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    EMACS_CONFIG_SRC="${./configs}"
    EMACS_CONFIG_DEST="${config.home.homeDirectory}/.config/emacs"

    $DRY_RUN_CMD mkdir -p "$EMACS_CONFIG_DEST"
    $DRY_RUN_CMD ${pkgs.rsync}/bin/rsync -a --exclude='elpaca/' --exclude='elfeed/' "$EMACS_CONFIG_SRC/" "$EMACS_CONFIG_DEST/"
    $DRY_RUN_CMD chmod -R u+w "$EMACS_CONFIG_DEST"
  '';

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
}
