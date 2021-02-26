#!/usr/bin/env bash

## Maybe update main branch from github first
git pull origin

## To copy the files/folders (that shouldn't be symlinked) into $HOME
echo "Setting out to copy dotfiles from repo into your home folder"
cd "$(dirname "${BASH_SOURCE}")";

function doIt() {
	rsync    --exclude ".DS_Store" \
	--exclude "DISABLED" \
		-avh --no-perms ./HOME/ ~;

#	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;

echo "Dotfiles copy done."

source setup/install.sh

