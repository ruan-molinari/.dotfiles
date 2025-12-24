#!/usr/bin/env nu

# Files and directories in root of these dotfiles
const NOT_DOTFILES = [
  .gitignore
  README.md
  install.sh
  scripts

]
const DOTFILES_ROOT_DIR = $"(path self | path dirname)/.."

def aoeu [
  --all, -a # Link all configs
] {
  ln -rs ../keyd/ /etc/;
  ln -rs ../gamemode.ini /etc/;
}
# stow --target ../.config . --override=ghostty

def all-dotfiles [] {
  ls $DOTFILES_ROOT_DIR | where ($it.name | path basename) not-in $NOT_DOTFILES;
}

all-dotfiles
