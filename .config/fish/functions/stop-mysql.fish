function stop-mysql --wraps='systemctl stop mariadb.service' --description 'alias stop-mysql systemctl stop mariadb.service'
  systemctl stop mariadb.service $argv
        
end
