function start-mongo --wraps='systemctl start mongodb.service' --description 'alias start-mongo systemctl start mongodb.service'
  systemctl start mongodb.service $argv
        
end
