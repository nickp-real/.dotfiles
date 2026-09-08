function rebuild-hypr --wraps="yay -Qq | grep -E '^.*(hypr|aquamarine).*-git\$' | xargs yay -S --rebuild --rebuildall --rebuildtree --noconfirm" --wraps="yay -Qq | grep -E '^.*(hypr|aquamarine).*-git\$' | xargs yay -S --rebuild --rebuildall --noconfirm" --wraps="yay -Qq | grep -E '^.*(hypr|aquamarine).*-git\$' | xargs yay -S --rebuild --noconfirm" --description "alias rebuild-hypr yay -Qq | grep -E '^.*(hypr|aquamarine).*-git\$' | xargs yay -S --rebuild --noconfirm"
    yay -Qq | grep -E '^.*(hypr|aquamarine).*-git$' | xargs yay -S --rebuild --noconfirm $argv
end
