# ALIAS
alias python "python3.10"
alias ls "exa"
alias ll "exa -l -g --icons"
alias lla "ll -a"
alias llt "ll -T"
alias diff 'diff --color=auto'
alias grep 'grep --color=auto'
alias ip 'ip -color=auto'
alias pip_update 'pip list | cut -d" " -f1 | tail -n+3 | xargs pip install --upgrade'
alias mv "mv -v"
alias cp "cp -v"
alias rm "rm -v"
alias du "du -chsh"
# alias cmd "cmd.exe"
# alias pwsh "pwsh.exe"
# alias open "wslview"
alias vim "nvim"
# alias v "nvim"
alias battery "cat /sys/class/power_supply/BAT0/capacity"

# Docker
alias docker-start "systemctl start docker.service"
alias docker-stop "systemctl stop docker.service"

# MongoDB
alias mongo-start "systemctl start mongodb.service"
alias mongo-stop "systemctl stop mongodb.service"

# Arch
alias pac "sudo pacman -S"
alias pac_autoremove "sudo pacman -Rcs $(pacman -Qdtq)"

# SET PATH
fish_add_path ~/.cargo/bin 
fish_add_path ~/.local/bin 
fish_add_path $HOME/.pub-cache/bin 
fish_add_path ~/.nvm/versions/node/v16.15.1/bin 

# pnpm
set -gx PNPM_HOME "/home/nickp_real/.local/share/pnpm"
fish_add_path "$PNPM_HOME" 
# pnpm end

# Go path
set -gx GOPATH $HOME/go
fish_add_path $GOPATH/bin 

# JAVA_HOME
set -gx JAVA_HOME /usr/lib/jvm/java-19-openjdk
fish_add_path $JAVA_HOME/bin 

# ANDROID_HOME
set -gx ANDROID_HOME $HOME/Android/Sdk
fish_add_path $ANDROID_HOME/cmdline-tools/latest/bin 
fish_add_path $ANDROID_HOME/platform-tools 
fish_add_path $ANDROID_HOME/emulator 
fish_add_path $ANDROID_HOME/tools 

# FLUTTER_ROOT
set -x FLUTTER_ROOT $HOME/Dev-tools/flutter
fish_add_path $FLUTTER_ROOT/bin 

# Rofi
fish_add_path $HOME/.config/rofi/scripts 

# SET VAR
set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR 
set -gx CLICOLOR 1
set -gx LS_COLORS "ow=1;102;90"
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8
set -gx LESS '-R --use-color -Dd+r$Du+b'
set -gx MANPAGER 'nvim +Man!'

# fish var
set -g fish_term24bit 1
set -g fish_color_command green 
set -g fish_color_normal brwhite
set -g fish_color_option blue
set -g fish_color_param blue 
set -g async_prompt_on_variable fish_bind_mode PWD

# fzf
set -gx fzf_preview_dir_cmd exa --all --color=always
# set fzf_fd_opts --hidden --exclude=.git
set -gx FZF_DEFAULT_OPTS --color=fg:#abb2bf,bg:#282c34,hl:#61afef --color=fg+:#abb2bf,bg+:#393f4a,hl+:#528bff --color=info:#ebd09c,prompt:#98c379,pointer:#56b6c2 --color=marker:#e06c75,spinner:#c678dd,header:#56b6c2

# qt5
set -gx QT_QPA_PLATFORMTHEME qt5ct
#
# STARSHIP INIT
starship init fish | source

# The Fuck INIT
thefuck --alias | source

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end
