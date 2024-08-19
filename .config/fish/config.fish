# run when login
if status is-login
  # launch Hyprland on tty
  set -l TTY1 (tty)
  [ "$TTY1" = "/dev/tty1" ] && exec Hyprland

  # pnpm
  set -gx PNPM_HOME "/home/nickp_real/.local/share/pnpm"

  # Go path
  set -gx GOPATH $HOME/go

  # JAVA_HOME
  set -gx JAVA_HOME /usr/lib/jvm/java-21-openjdk

  # ANDROID_HOME
  set -gx ANDROID_HOME $HOME/Android/Sdk

  # FLUTTER_ROOT
  set -x FLUTTER_ROOT $HOME/Dev-tools/flutter

  # SET VAR
  set -gx EDITOR nvim
  set -gx VISUAL $EDITOR
  set -gx SUDO_EDITOR $EDITOR
  set -gx CLICOLOR 1
  set -gx LS_COLORS "ow=1;102;90"
  set -gx LESS '-R --use-color -Dd+r$Du+b'
  set -gx MANPAGER 'nvim +Man!'
  set -gx GRIMBLAST_EDITOR 'swappy -f'

  # theme
  source ~/.config/fish/themes/onedarkpro.fish

  # remove greeting
  set -gx fish_greeting

  # set cursor blink
  set -gx fish_cursor_unknown block blink

  # fzf
  set -gx fzf_preview_dir_cmd exa --all --color=always
  # set fzf_fd_opts --hidden --exclude=.git
  set -gx FZF_DEFAULT_OPTS --color=fg:#abb2bf,bg:-1,hl:#61afef --color=fg+:#abb2bf,bg+:#393f4a,hl+:#528bff --color=info:#ebd09c,prompt:#98c379,pointer:#56b6c2 --color=marker:#e06c75,spinner:#c678dd,header:#56b6c2
end

if status --is-interactive
  # tabtab source for packages
  # uninstall by removing these lines
  [ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

  # RUBY ENV INIT
  rbenv init - fish | source

  # Zoxide Init
  zoxide init fish | source

  # DIRENV INIT
  direnv hook fish | source

  # STARSHIP INIT
  starship init fish | source
end
