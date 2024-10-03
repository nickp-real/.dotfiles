# run when login
if status is-login
  # launch Hyprland on tty
  set -l TTY1 (tty)
  [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
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

  # fzf
  set -x fzf_preview_dir_cmd exa --all --color=always
  # set fzf_fd_opts --hidden --exclude=.git
  set -x FZF_DEFAULT_OPTS --color=fg:#abb2bf,bg:-1,hl:#61afef --color=fg+:#abb2bf,bg+:#393f4a,hl+:#528bff --color=info:#ebd09c,prompt:#98c379,pointer:#56b6c2 --color=marker:#e06c75,spinner:#c678dd,header:#56b6c2

  # ATAC
  set -x ATAC_KEY_BINDINGS ~/.config/atac/key_bindings.toml

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

  source /opt/asdf-vm/asdf.fish
end
