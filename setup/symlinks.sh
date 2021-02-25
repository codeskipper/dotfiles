#ln -sfv "$DOTFILES_DIR/HOME_symlinked/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/HOME_symlinked/.gitignore_global" ~
#ln -sfv "$DOTFILES_DIR/HOME_symlinked/.zshrc" ~

## some utils that are hard to find
[[ -f /Library/Application\ Support/AirWatch/Data/Munki/bin/munkiimport ]] && sudo ln -sfv /Library/Application\ Support/AirWatch/Data/Munki/bin/munkiimport /usr/local/bin/
