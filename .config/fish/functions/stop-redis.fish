function stop-redis --wraps='systemctl stop redis.service' --description 'alias stop-redis systemctl stop redis.service'
  systemctl stop redis.service $argv
        
end
