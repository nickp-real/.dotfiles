# run when login
if status --is-login
  # SET PATH
  fish_add_path ~/.cargo/bin
  fish_add_path ~/.local/bin
  fish_add_path $HOME/.pub-cache/bin

  # pnpm
  set -gx PNPM_HOME "/home/nickp_real/.local/share/pnpm"
  if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
  end
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

  # Firebase cli
  fish_add_path $HOME/.pub-cache/bin

  # Rofi
  fish_add_path $HOME/.config/rofi/scripts

  # SET VAR
  set -gx EDITOR nvim
  set -gx VISUAL $EDITOR
  set -gx SUDO_EDITOR $EDITOR
  set -gx CLICOLOR 1
  set -gx LS_COLORS "ow=1;102;90"
  set -gx LESS '-R --use-color -Dd+r$Du+b'
  set -gx MANPAGER 'nvim +Man!'
  set -gx GRIMBLAST_EDITOR 'swappy -f'

# fish var
  set -g fish_color_command green
  set -g fish_color_normal brwhite
  set -g fish_color_option blue
  set -g fish_color_param blue

  # fzf
  set -gx fzf_preview_dir_cmd exa --all --color=always
  # set fzf_fd_opts --hidden --exclude=.git
  set -gx FZF_DEFAULT_OPTS --color=fg:#abb2bf,bg:#282c34,hl:#61afef --color=fg+:#abb2bf,bg+:#393f4a,hl+:#528bff --color=info:#ebd09c,prompt:#98c379,pointer:#56b6c2 --color=marker:#e06c75,spinner:#c678dd,header:#56b6c2
end

# RUBY ENV INIT
status --is-interactive; and rbenv init - fish | source

# Zoxide Init
zoxide init fish | source

# DIRENV INIT
direnv hook fish | source

# STARSHIP INIT
starship init fish | source
