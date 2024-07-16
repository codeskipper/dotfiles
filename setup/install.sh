#!/usr/bin/env bash



echo "setup/install.sh script starting to update your settings to those from the dotfiles repo"


export DOTFILES_DIR EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"

# ensure XCode CommandLine tools are installed, use installer script by Graham Pugh and Rich Trouton
# https://raw.githubusercontent.com/autopkg/grahampugh-recipes/main/_Scripts/XcodeCommandLineTools-install.sh
source "$DOTFILES_DIR/setup/macOS/XcodeCommandLineTools-install.sh"

# Install brew with packages & casks, composer and yarn global packages
source "$DOTFILES_DIR/setup/brew.sh"

# Install Oh my ZSH
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install NVM (see nvm.sh)
#curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

# Bunch of symlinks
source "$DOTFILES_DIR/setup/symlinks.sh"

# Vscode extensions
#. "$DOTFILES_DIR/vscode/extensions.sh"

# Clear cache
#. "$DOTFILES_DIR/bin/dotfiles" clean

# Replace default hosts file
#. "$DOTFILES_DIR/install/hosts.sh"

# Add keys from keychain to ssh agent
#ssh-add -A 2>/dev/null;

# Setup macos defaults and add apps to dock
source "$DOTFILES_DIR/setup/macOS/dock.sh"
# macOS defaults.sh must run last as it kills affected apps including Terminals after adjusting their settings
source "$DOTFILES_DIR/setup/macOS/defaults.sh"


#echo "setup/install.sh script done"
