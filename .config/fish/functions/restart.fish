function restart --wraps='systemctl restart' --description 'alias restart systemctl restart'
  systemctl restart $argv
        
end
