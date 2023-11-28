function start-postgresql --wraps='systemctl start postgresql.service' --description 'alias start-postgresql systemctl start postgresql.service'
  systemctl start postgresql.service $argv
        
end
