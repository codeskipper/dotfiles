#!/usr/bin/env bash

echo "setup/symlink.sh linking some dotfiles in the repo to your home folder"
echo "so you can version control updated settings and push to your dotfiles repo if desired"

#ln -sfv "$DOTFILES_DIR/HOME_symlinked/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/HOME_symlinked/.gitignore_global" ~
#ln -sfv "$DOTFILES_DIR/HOME_symlinked/.zshrc" ~

## some utils that are hard to find
echo "and some more for convenient access"
[[ -f /Library/Application\ Support/AirWatch/Data/Munki/bin/munkiimport ]] && sudo ln -sfv /Library/Application\ Support/AirWatch/Data/Munki/bin/munkiimport /usr/local/bin/

echo "setup/symlink.sh done"