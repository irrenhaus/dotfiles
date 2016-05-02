export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Needed for yeoman to work correctly
export NODE_PATH=$NODE_PATH:`npm root -g`

