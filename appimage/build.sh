#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR
mkdir AppDir/usr
mkdir AppDir/usr/bin
mkdir AppDir/usr/config
mkdir AppDir/usr/config/nvim
wget https://github.com/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz
tar -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
mv nvim-linux64/* AppDir/usr/bin/
rm -r nvim-linux64
cp ../init.lua AppDir/usr/config/nvim/init.lua
appimagetool AppDir
rm -r AppDir/usr
# rm winvim.AppImage
# mv Walter*.AppImage winvim.AppImage
