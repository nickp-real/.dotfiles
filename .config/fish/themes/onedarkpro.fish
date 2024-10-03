# Onedarkpro Color Palette
set -l white abb2bf
set -l black 282c34
set -l magenta c678dd
set -l red e06c75
set -l yellow e5c07b
set -l green 98c379
set -l cyan 56b6c2
set -l blue 61afef
set -l comment 5c6370

# bright
set -l brwhite c8cdd5
set -l brblack 3e4451
set -l brred e9969d
set -l brgreen b3d39c
set -l bryellow edd4a6
set -l brblue 8fc6f4
set -l brmagenta d7a1e7
set -l brcyan 7bc6d0

# Syntax Highlighting Colors
set -x fish_color_normal $brwhite
set -x fish_color_command $green
set -x fish_color_keyword $blue
set -x fish_color_quote $yellow
set -x fish_color_redirection $brblue
set -x fish_color_end $blue
set -x fish_color_error $red
set -x fish_color_param $blue
set -x fish_color_option $blue
set -x fish_color_comment $comment
set -x fish_color_selection --reverse
set -x fish_color_search_match --background=$brblack
set -x fish_color_operator $blue
set -x fish_color_escape $blue
set -x fish_color_autosuggestion $comment

# Completion Pager Colors
set -x fish_pager_color_progress $brwhite --background=$cyan
set -x fish_pager_color_prefix $cyan --underline
set -x fish_pager_color_completion $white
set -x fish_pager_color_description $yellow
set -x fish_pager_color_selected_background --reverse
