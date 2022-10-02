# Adapted from here https://github.com/zimfw/pacman
set -q __pacman_abbr_initialized; and exit 0

function __pacman_abbr_install --on-event fish_pacman_install
    set -U __pacman_abbr_abbreviations

    function __pacman_abbr -d "Create Git plugin abbreviation"
        set -l name $argv[1]
        set -l body $argv[2..-1]
        abbr -a $name $body
        set -a __pacman_abbr_abbreviations $name
    end

    # build package in current directory, cleanup, and install
    __pacman_abbr pacb 'makepkg -sci'

    #
    # Install

    #
    #NOTE: Installing/upgrading individual packages is NOT supported. Sync and upgrade ALL on install.

    # install, sync, and upgrade packages
    __pacman_abbr paci 'pacman -Syu'

    # install packages without syncing
    __pacman_abbr pacI 'pacman -S'

    # install, sync, and upgrade packages (forcibly refresh package lists)
    __pacman_abbr pacu 'pacman -Syyu'

    # install packages by filename
    __pacman_abbr pacU 'pacman -U'

    # install all packages in current directory
    __pacman_abbr pacd 'pacman -U *.pkg.*'


    #
    # Remove
    #

    # remove package and unneeded dependencies
    __pacman_abbr pacr 'pacman -R'

    # remove package, unneeded dependencies, and configuration files
    __pacman_abbr pacrm 'pacman -Rns'


    #
    # Query
    #

    # query package information from the remote repository
    __pacman_abbr pacq 'pacman -Si'

    # query package information from the local repository
    __pacman_abbr pacQ 'pacman -Qi'


    #
    # Search
    #

    # search for package in the remote repository
    __pacman_abbr pacs 'pacman -Ss'

    # search for the package in the local repository
    __pacman_abbr pacS 'pacman -Qs'


    #
    # Orphans
    #

    # list orphan packages
    __pacman_abbr pacol 'pacman -Qdt'

    # remove orphan packages
    __pacman_abbr pacor 'pacman -Rns (pacman -Qtdq)'


    #
    # Ownership
    #

    # list all files that belong to a package
    __pacman_abbr pacown 'pacman -Ql'

    # show package(s) owning the specified file
    __pacman_abbr pacblame 'pacman -Qo'

    __pacman_abbr upgrade 'sudo pacman -Sy && sudo powerpill -Su && paru -Su'
end

function __pacman_abbr_update --on-event fish_pacman_update
    __pacman_abbr_uninstall
    __pacman_abbr_install
end

function __pacman_abbr_uninstall --on-event fish_pacman_uninstall
    for ab in $__pacman_abbr_abbreviations
        abbr --erase $ab
    end
    set -Ue __pacman_abbr_abbreviations
    set -Ue __pacman_abbr_initialized
end
