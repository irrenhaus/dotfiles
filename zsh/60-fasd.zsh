which fasd 2>/dev/null 1>/dev/null

if [ "$?" -eq "0" ]; then
  eval "$(fasd --init auto)"
fi
