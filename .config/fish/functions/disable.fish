function disable --wraps 'systemctl disable' --description 'alias disable systemctl disable'
  systemctl disable $argv
        
end
