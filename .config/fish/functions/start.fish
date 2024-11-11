function start --wraps='systemctl start' --description 'alias start systemctl start'
  systemctl start $argv
        
end
