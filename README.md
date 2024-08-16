# My `neovim` config
My personal `nvim` configuration. I'm a sucker for strong typing, so this configuration is written in TypeScript and transpiled to a singular LUA file. I personally find it very handy to be able to use my entire neovim configuration on a remote machine by pulling a single file, so I've included the output result (`init.lua`) in the repository, as well as provided commands to install / temporarily use it.

# Installation
## Arch Linux
```bash
wget https://raw.githubusercontent.com/Walter-Neils/neovim-config/main/init.lua -O ~/.config/nvim/init.lua
```

# Try it out
## Linux w/ Modern `glibc`
```bash
cd /tmp/;wget https://github.com/Walter-Neils/neovim-config/raw/main/appimage/standard/winvim-x86_64.AppImage && chmod +x ./winvim-x86_64.AppImage && ./winvim-x86_64.AppImage
```
## Linux w/ Old `glibc` (2.17)
```bash
cd /tmp/;wget https://github.com/Walter-Neils/neovim-config/raw/main/appimage/legacy-glibc/winvim-x86_64.AppImage && chmod +x ./winvim-x86_64.AppImage && ./winvim-x86_64.AppImage
```
