function start-docker --wraps='systemctl start docker.service' --description 'alias start-docker systemctl start docker.service'
  systemctl start docker.service $argv
        
end
