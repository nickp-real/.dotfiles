function rebuild-package --wraps='checkrebuild | cut -f 2 | xargs yay -S --rebuild --rebuildall --rebuildtree --noconfirm' --wraps='checkrebuild | cut -f 2 | xargs yay -S --rebuild --noconfirm' --description 'alias rebuild-package checkrebuild | cut -f 2 | xargs yay -S --rebuild --noconfirm'
    checkrebuild | cut -f 2 | xargs yay -S --rebuild --noconfirm $argv
end
