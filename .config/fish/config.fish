# ALIAS
alias python "python3.10"
alias ll "exa -l -g --icons"
alias lla "ll -a"
alias llt "ll -T"
alias cmd "cmd.exe"
alias pwsh "pwsh.exe"
alias open "wslview"
alias vim "nvim"
alias v "nvim"

# SET PATH
set -gx PATH ~/.cargo/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH $HOME/.pub-cache/bin $PATH
set -gx PATH ~/.nvm/versions/node/v16.14.2/bin $PATH

# JAVA_HOME
set -gx JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64 $JAVA_HOME

# ANDROID_HOME
set -gx ANDROID_HOME $HOME/Android/Sdk $ANDROID_HOME
set -gx PATH $ANDROID_HOME/cmdline-tools/latest/bin $PATH
set -gx PATH $ANDROID_HOME/platform-tools $PATH
set -gx PATH $ANDROID_HOME/emulator $PATH
set -gx PATH $ANDROID_HOME/tools $PATH

# FLUTTER_ROOT
set -gx FLUTTER_ROOT $HOME/Software/Flutter/Sdk $FLUTTER_ROOT
set -gx PATH $FLUTTER_ROOT/bin $PATH

# SET VAR
set -gx EDITOR nvim
set -gx LS_COLORS "ow=1;102;90"
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8
set -gx LANGUAGE en_US.UTF-8

set -gx fish_color_command green 
set -gx fish_color_normal brwhite
set -gx fish_color_option blue
set -gx fish_color_param blue

# STARSHIP INIT
starship init fish | source 

thefuck --alias | source
