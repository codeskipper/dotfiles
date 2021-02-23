#!/usr/bin/env bash

## Maybe stick to main branch
#git pull origin main;

## To copy the files/folders (that shouldn't be symlinked) into $HOME
cd "$(dirname "${BASH_SOURCE}")/HOME";

function doIt() {
	rsync    --exclude ".DS_Store" \
                 --exclude "DISABLED" \
		-avh --no-perms . ~;
	source ~/.bash_profile;
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

## Now setup the rest
cd "$(dirname "${BASH_SOURCE}")";

source setup/install.sh

