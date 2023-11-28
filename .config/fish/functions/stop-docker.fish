function stop-docker --wraps='systemctl stop docker.service' --description 'alias stop-docker systemctl stop docker.service'
  systemctl stop docker.service $argv
        
end
