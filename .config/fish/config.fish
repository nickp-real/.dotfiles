# ALIAS
alias python "python3.10"
alias ll "exa -l -g --icons"
alias lla "ll -a"
alias llt "ll -T"
alias cmd "cmd.exe"
alias pwsh "pwsh.exe"
# alias open "wslview"
alias vim "nvim"
alias v "nvim"

# Arch
alias pac "sudo pacman -S"
alias pac_autoremove "sudo pacman -Rcs $(pacman -Qdtq)"

# SET PATH
set -gx PATH ~/.cargo/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH $HOME/.pub-cache/bin $PATH
set -gx PATH ~/.nvm/versions/node/v16.15.0/bin $PATH

# JAVA_HOME
set -x JAVA_HOME /usr/lib/jvm/java-18-openjdk
set -gx PATH $JAVA_HOME/bin $PATH

# ANDROID_HOME
set -x ANDROID_HOME $HOME/Android/Sdk $ANDROID_HOME
set -gx PATH $ANDROID_HOME/cmdline-tools/latest/bin $PATH
set -gx PATH $ANDROID_HOME/platform-tools $PATH
set -gx PATH $ANDROID_HOME/emulator $PATH
set -gx PATH $ANDROID_HOME/tools $PATH

# FLUTTER_ROOT
set -x FLUTTER_ROOT $HOME/Software/flutter
set -gx PATH $FLUTTER_ROOT/bin $PATH

# SET VAR
set -U EDITOR nvim
set -U VISUAL $EDITOR
set -U CLICOLOR 1
set -U LS_COLORS "ow=1;102;90"
set -U LC_ALL en_US.UTF-8
set -U LANG en_US.UTF-8
set -U LANGUAGE en_US.UTF-8

set -U fish_color_command green 
set -U fish_color_normal brwhite
set -U fish_color_option blue
set -U fish_color_param blue

# STARSHIP INIT
starship init fish | source

# The Fuck INIT
thefuck --alias | source

if test -z "$DISPLAY"; and test "$XDG_VTNR" -eq 1
    exec startx
end
