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
#████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗ █████╗ ██╗         ██████╗  █████╗  ██████╗██╗  ██╗ █████╗  ██████╗ ███████╗███████╗
#╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗██║         ██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔══██╗██╔════╝ ██╔════╝██╔════╝
#   ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║███████║██║         ██████╔╝███████║██║     █████╔╝ ███████║██║  ███╗█████╗  ███████╗
#   ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██╔══██║██║         ██╔═══╝ ██╔══██║██║     ██╔═██╗ ██╔══██║██║   ██║██╔══╝  ╚════██║
#   ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██║  ██║███████╗    ██║     ██║  ██║╚██████╗██║  ██╗██║  ██║╚██████╔╝███████╗███████║
#   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝
#
{pkgs, ...}: {
  #            ┓
  #┏┓┏┓┏┓┏┓┏┓┏┓┃
  #┗┫┗ ┛┗┗ ┛ ┗┻┗
  # ┛

  services.udev.packages = [
    pkgs.keymapp
    pkgs.zsa-udev-rules
  ];

  environment.systemPackages = with pkgs; [
    alejandra # nix formatter
    bat # improved cat
    isync # mbsync - mail synchronisation (for mu4e)
    bluetui # tui bluetooth manager
    btop # tui taskmanager
    claude-code
    docker # docker containters
    emacs # emacs- I know technically not terminal but close enough
    # file
    fastfetch # system info
    fd # improved find
    fzf # fuzzy finder
    gh # github cli
    git # git
    impala # tui wifi manager
    kontroll # keyboard smart control
    lazygit # tui git interface
    lsd # improved ls
    man-db # manual page browser
    mu # mail indexer (required for mu4e)
    pipenv # python project/virtualenv manager (doom python)
    python3Packages.isort # python import sorting (doom python)
    python3Packages.pyflakes # python linting (doom python)
    python3Packages.pytest # python test runner (doom python)
    ripgrep # improved grep
    shellcheck # shell script linter (doom sh)
    shfmt # shell formatter (doom sh)
    starship # shell prompt
    timg # tty image viewer
    tldr # man pages tldr
    unzip # unzip
    vim # base vim
    wally-cli # zsa flasher
    zoxide # improved cd
  ];

  # ┓   ┓┓
  #┏┣┓┏┓┃┃
  #┛┛┗┗ ┗┗

  programs.zsh.enable = true;
}
