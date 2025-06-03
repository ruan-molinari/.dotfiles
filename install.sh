#!/bin/bash
echo "Stowing dotfiles..."
stow -S -t $HOME/.config -d ./ ./
echo "Finished!"
