#!/bin/bash
echo "Change to home folder"
cd $HOME
echo "Clone dotfiles"
git clone https://github.com/ruan-molinari/dotfiles.git .dotfiles
echo "Change to dotfiles"
cd .dotfiles
echo "Stow dotfiles"
stow nvim
stow kitty
stow nushell
stow wezterm
echo "Back to home"\
cd ..
