function pip_update --wraps='pip list | cut -d" " -f1 | tail -n+3 | xargs pip install --upgrade' --description 'alias pip_update pip list | cut -d" " -f1 | tail -n+3 | xargs pip install --upgrade'
  pip list | cut -d" " -f1 | tail -n+3 | xargs pip install --upgrade $argv
        
end
