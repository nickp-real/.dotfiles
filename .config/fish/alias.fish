# EXA
alias -s ls "exa --icons -s type"
alias -s ll "exa -l -g --icons -s type"
alias -s la "ll -a -s type"
alias -s lt "ll -T -s type"
alias -s t "exa --tree -s type"

# Diary
alias -s diff 'diff --color=auto'
alias -s grep 'grep --color=auto'
alias -s ip 'ip -color=auto'
alias -s mv "mv -v"
alias -s cp "cp -v"
alias -s rm "rm -v"
alias -s du "du -chsh"
alias -s cls "clear"

# Window/WSL
# alias -s cmd "cmd.exe"
# alias -s pwsh "pwsh.exe"
# alias -s open "wslview"

# nvim
alias -s vim "nvim"
alias -s nv "nvim"
# alias -s v "nvim"


# Python
alias -s python "python3"
alias -s pip_update 'pip list | cut -d" " -f1 | tail -n+3 | xargs pip install --upgrade'

# Docker
alias -s start-docker "systemctl start docker.service"
alias -s stop-docker "systemctl stop docker.service"

# MongoDB
alias -s start-mongo "systemctl start mongodb.service"
alias -s stop-mongo "systemctl stop mongodb.service"

# Postgresql
alias -s start-postgresql "systemctl start postgresql.service"
alias -s stop-postgresql "systemctl stop postgresql.service"

# MariaDB, MYSQL
alias -s start-mysql "systemctl start mariadb.service"
alias -s stop-mysql "systemctl stop mariadb.service"

# Redis
alias -s start-redis "systemctl start redis.service"
alias -s stop-redis "systemctl stop redis.service"

# Arch
alias -s pac "sudo pacman -S"
alias -s pac_autoremove "sudo pacman -Rcs $(pacman -Qdtq)"
alias -s battery "cat /sys/class/power_supply/BAT0/capacity"

# Lazy thingy
alias -s lzg lazygit
alias -s lzd lazydocker

# Node Package Manager
alias -s pn "pnpm"
alias -s px "pnpx"
