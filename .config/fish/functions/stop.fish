function stop --wraps 'systemctl stop' --description 'alias stop systemctl stop'
  systemctl stop $argv
        
end
