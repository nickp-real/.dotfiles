function start-redis --wraps='systemctl start redis.service' --description 'alias start-redis systemctl start redis.service'
  systemctl start redis.service $argv
        
end
