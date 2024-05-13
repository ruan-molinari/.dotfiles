#!/bin/bash
echo "Stow dotfiles"
stow nvim
stow nushell
stow wezterm
echo "Back to home"
cd ..
