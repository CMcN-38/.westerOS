# home.nix
{
  config,
  pkgs,
  ...
}: {
  programs.zsh.enable = true;
  programs.zsh.dotDir = "/home/cameron/.config/zsh";
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.autosuggestion.enable = true;
  programs.zsh.historySubstringSearch.enable = true;

  programs.zsh.shellAliases = {
    vimrc = "vim ~/.config/nvim/init.lua";
    vimplug = "vim ~/.config/nvim/lua/plugins.lua";
    zshrc = "vim ~/.config/zsh/.zshrc";

    # Colorize grep output (good for log files)
    grep = "rg";
    egrep = "egrep --color=auto";
    fgrep = "fgrep --color=auto";

    # Default to nvim
    vim = "nvim";
    vi = "nvim";
    nano = "nvim";
    v = "nvim";

    # confirm before overwriting something
    cp = "cp -i";
    mv = "mv -i";
    rm = "rm -i";

    ## timg
    timg = "timg -p k";
    icat = "timg -p k";

    # Colour
    ls = "lsd";

    # improved cat and find
    cat = "bat";
    find = "fd";

    # easier to read disk
    df = "df -h"; # human-readable sizes
    free = "free -m"; # show sizes in MB

    # Navigate shortcuts
    cdroot = "cd ~/../../..";
    cdcon = "cd ~/.config/";

    ts = "westerOS_tmux_sessioniser";
    cheat = "westerOS_tmux_cheatsheet";
  };

  programs.zsh.sessionVariables = {
    XDG_CONFIG_HOME = "/home/cameron/.config";
    PATH = "$PATH:/usr/local/bin/:$HOME/.go/bin:$HOME/.westerOS/bin";
    wallpaperDir = "/home/cameron/4_media/41_wallpapers/4k/";
  };

  programs.zsh.initExtraFirst = ''
    setopt correct # correct spelling errors
    setopt extendedglob # enable extended globbing
    setopt nocaseglob # case insensitive globbing
    setopt rcexpandparam # expand parameter in place
    setopt numericglobsort # sort filenames numerically when it makes sense
    setopt appendhistory # append to the history file, don't overwrite it
    setopt histignorealldups # don't record duplicates in the history
    setopt inc_append_history # add commands to the history file as they are run
  '';

  programs.zsh.initExtra = ''
    bindkey -s "^F" "/usr/local/bin/tmux-sessioniser"

    plugins=(git)

    # zsh vim mode
    bindkey -v
    export KEYTIMEOUT=1

    bindkey -v '^?' backward-delete-char

    # Change cursor shape for different vi modes.
    function zle-keymap-select () {
        case $KEYMAP in
            vicmd) echo -ne '\e[1 q';;      # block
            viins|main) echo -ne '\e[5 q';; # beam
        esac
    }
    zle -N zle-keymap-select
    zle-line-init() {
        zle -K viins
        echo -ne "\e[5 q"
    }
    zle -N zle-line-init
    echo -ne '\e[5 q' # Use beam shape cursor on startup.
    preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

    # ZSH Functions
    function zsh_add_file() {
        [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
    }

    function zsh_add_plugin() {
        PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
        if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
            zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
            zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
        else
            git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
        fi
    }

    function zsh_add_completion() {
        PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
        if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
    		completion_file_path=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
    		fpath+="$($dirname "$completion_file_path")"
            zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
        else
            git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    		fpath+=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
            [ -f $ZDOTDIR/.zccompdump ] && $ZDOTDIR/.zccompdump
        fi
    	completion_file="$(basename "$completion_file_path")"
    	if [ "$2" = true ] && compinit "$completion_file:1"
    }

    export PATH="$HOME/.cargo/bin:$PATH"

    eval "$(zoxide init --cmd cd zsh)"
  '';
}
