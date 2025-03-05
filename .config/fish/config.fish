# run when login
if status is-login
    # launch Hyprland on tty
    set -l TTY1 (tty)
    [ "$TTY1" = /dev/tty1 ] && exec Hyprland
    # [ "$TTY1" = "/dev/tty1" ] && exec uwsm start hyprland-uwsm.desktop
    # if [ "$TTY1" = "/dev/tty1" ]; and uwsm check may-start
    # exec uwsm start hyprland-uwsm.desktop
    # exec systemd-cat -t uwsm_start uwsm start default
    # end
end

if status --is-interactive
    # pnpm
    set -x PNPM_HOME "/home/nickp_real/.local/share/pnpm"

    # Go path
    set -x GOPATH $HOME/go

    # JAVA_HOME
    set -x JAVA_HOME /usr/lib/jvm/java-21-openjdk

    # ANDROID_HOME
    set -x ANDROID_HOME $HOME/Android/Sdk

    # FLUTTER_ROOT
    set -x FLUTTER_ROOT $HOME/Dev-tools/flutter

    # SET VAR
    set -x EDITOR nvim
    set -x VISUAL $EDITOR
    set -x SUDO_EDITOR $EDITOR
    set -x CLICOLOR 1
    set -x LS_COLORS "ow=1;102;90"
    set -x LESS '-R --use-color -Dd+r$Du+b'
    set -x MANPAGER 'nvim +Man!'
    set -x GRIMBLAST_EDITOR 'swappy -f'

    # theme
    source ~/.config/fish/themes/onedarkpro.fish

    # remove greeting
    set -x fish_greeting

    # set cursor blink
    set -x fish_cursor_unknown block blink
    set -x fish_cursor_insert line blink

    # fzf
    set -x fzf_preview_dir_cmd exa --all --color=always
    # set fzf_fd_opts --hidden --exclude=.git
    set -x FZF_DEFAULT_OPTS --color=fg:#abb2bf,bg:-1,hl:#61afef --color=fg+:#abb2bf,bg+:#393f4a,hl+:#528bff --color=info:#ebd09c,prompt:#98c379,pointer:#56b6c2 --color=marker:#e06c75,spinner:#c678dd,header:#56b6c2

    # ATAC
    set -x ATAC_KEY_BINDINGS ~/.config/atac/key_bindings.toml
end
