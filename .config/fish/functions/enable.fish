function enable --wraps 'systemctl enable' --description 'alias enable systemctl enable'
  systemctl enable $argv
        
end
