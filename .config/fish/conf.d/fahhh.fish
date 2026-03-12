function fahhh_handler --on-event fish_postexec
    if test ! $status -eq 0
        and status --is-interactive
        pw-play ~/.config/fish/assets/fahhh-sound-effect.mp3 --volume 0.1 &
    end
end
