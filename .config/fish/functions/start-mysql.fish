function start-mysql --wraps='systemctl start mariadb.service' --description 'alias start-mysql systemctl start mariadb.service'
  systemctl start mariadb.service $argv
        
end
