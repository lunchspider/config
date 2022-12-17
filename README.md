my config files
To setup nvim do 
# Install NeoVim
`sudo dnf install nvim`
# Install config repo
`git clone https://github.com/lunchspider/config.git`
# Creating SymLink
`ln -s ~/.config/nvim config/nvim`
# Clone packer
`git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim `
# Launch nvim
`nvim +PackerInstall`

Enjoy!
