function stop-postgresql --wraps='systemctl stop postgresql.service' --description 'alias stop-postgresql systemctl stop postgresql.service'
  systemctl stop postgresql.service $argv
        
end
