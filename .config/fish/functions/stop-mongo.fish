function stop-mongo --wraps='systemctl stop mongodb.service' --description 'alias stop-mongo systemctl stop mongodb.service'
  systemctl stop mongodb.service $argv
        
end
