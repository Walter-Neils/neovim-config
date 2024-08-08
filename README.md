# My `neovim` config
My personal `nvim` configuration. I'm a sucker for strong typing, so this configuration is written in TypeScript and transpiled to a singular LUA file. I personally find it very handy to be able to use my entire neovim configuration on a remote machine by pulling a single file, so I've included the output result (`init.lua`) in the repository, as well as provided commands to install / temporarily use it.

# Installation
## Arch Linux
```bash
wget https://raw.githubusercontent.com/Walter-Neils/neovim-config/main/init.lua -O ~/.config/nvim/init.lua
```

# Try it out
## Arch Linux
```bash
EPHEMERAL_NEOVIM_ENVIRONMENT="nvim-winconf"
mkdir ~/.config/$EPHEMERAL_NEOVIM_ENVIRONMENT/
wget https://raw.githubusercontent.com/Walter-Neils/neovim-config/main/init.lua -O ~/.config/$EPHEMERAL_NEOVIM_ENVIRONMENT/init.lua
NVIM_APPNAME=$EPHEMERAL_NEOVIM_ENVIRONMENT nvim
rm -rf ~/.config/$EPHEMERAL_NEOVIM_ENVIRONMENT
```
