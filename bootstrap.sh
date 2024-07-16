#!/usr/bin/env bash

# Get this scripts starting folder, this is the main folder of this repo
# :A resolves symlinks, and :h truncates the last path component
#script_path=${0:A:h}
script_path="$(dirname $0)"
this_script="$0"


# write timestamp + message to stdout
function log() {
	timestamp=$(date +%Y-%m-%d\ %H:%M:%S%z)
	echo "$timestamp [$0] $1"
}


# get parent folder of this script, we'll build dependencies on leaf folders to this repo
dev_main="$(dirname $script_path)"
log "dev_main is: $dev_main"

## Maybe update main branch from github first
# git pull origin

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

