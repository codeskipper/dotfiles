#!/usr/bin/env bash

echo "setup/brew.sh installing Homebrew if needed, and installing your standard formulae and casks"
# Check if brew is already installed (and in search path)
which -s brew
if [[ $? != 0 ]]; then
	# install Homebrew itself
	#ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	# Ruby installer is deprecated and rewritten in bash - so run this instead
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

	# check install went as planned
	if [[ $? != 0 ]]; then
		echo "Homebrew install did not succeed, aborting remainder of setup scripts"
		exit 1
	fi

	# Check if Homebrew got installed in the search path, on Silicon M1 Macs it does not by default
	if [[ ! $(which -s brew) ]]; then
		brewcmd="/usr/local/bin/brew"
		if [[ ! -x "$brewcmd" ]]; then
			brewcmd="/opt/homebrew/bin/brew"
			if [[ ! -x "$brewcmd" ]]; then
				brewcmd="/home/linuxbrew/.linuxbrew/bin/brew"
				if [[ ! -x "$brewcmd" ]]; then
					echo "Homebrew not found in a default path after install, panic, exiting"
					exit 1
				fi
			fi
		fi
		echo "Homebrew command found at $brewcmd"

		# find default shell profle or resource scipt, macOS treats shells started from GUI (Terminal) as login shell and doesn't source ~/.bashrc like in Linux
		DEFAULT_SHELL=$(basename "${SHELL}")
		case $(uname) in
			'Darwin')  if [[ $DEFAULT_SHELL == "zsh" ]]; then
					SHELL_RESOURCE="${HOME}/.zshrc"
				elif [[ $DEFAULT_SHELL == "bash" ]]; then
					SHELL_RESOURCE="${HOME}/.bash_profile"
				else
					SHELL_RESOURCE="UNKNOWN"
				fi
			;;
			'Linux') if [[ $DEFAULT_SHELL == "zsh" ]]; then
					SHELL_RESOURCE="${HOME}/.zshrc"
				elif [[ $DEFAULT_SHELL == "bash" ]]; then
					SHELL_RESOURCE="${HOME}/.bashrc"
				else
					SHELL_RESOURCE="UNKNOWN"
				fi

			;;
			*) SHELL_RESOURCE="UNKNOWN"
			;;
		esac
		if [[ SHELL_RESOURCE == "UNKNOWN" ]]; then
			echo "This script doesn't (yet) know how to add brew paths to the default shell resource file in your OS."
			echo "You may add those paths manually using the suggestions from the Homebrew installer script above."
			echo "Aborting remainder of setup scripts. You can re-run after adding Homebrew search paths to your config manually."
			exit 1
		else
			echo "Found your default shell to be: $DEFAULT_SHELL"
			echo "So appending Homebrew search paths lookup to it's resource file at $SHELL_RESOURCE"
			echo "appending the following:"
			echo  '    eval $('"$brewcmd"' shellenv)'
			echo 'eval $('"$brewcmd"' shellenv)' >> $SHELL_RESOURCE
			echo "which will expand to this:"
			echo "$($brewcmd shellenv)"
			echo "Now sourcing the file to apply to this shell session"
			source $SHELL_RESOURCE
			# check path setup went as planned
			if [[ $? != 0 || ! $(which -s brew) ]]; then
				echo "Failed to apply the path settings for Homebrew to your shell, bailing out."
				exit 1
			fi

		fi
	fi
else
	# Make sure we’re using the latest Homebrew.
	brew update

	# Upgrade any already-installed formulae.
	brew upgrade
fi

# Install command-line tools using Homebrew.

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
#brew install coreutils
#ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
#brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
#brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
#brew install gnu-sed --with-default-names
# Install a modern version of Bash.
#brew install bash
#brew install bash-completion2

# Switch to using brew-installed bash as default shell
#if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
#  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
#  chsh -s "${BREW_PREFIX}/bin/bash";
#fi;

# Install `wget` with IRI support.
#brew install wget --with-iri

# Install GnuPG to enable PGP-signing commits.
#brew install gnupg

# Install more recent versions of some macOS tools.
#brew install vim --with-override-system-vi
#brew install grep
#brew install openssh
#brew install screen
#brew install php
#brew install gmp

# Install font tools.
#brew tap bramstein/webfonttools
#brew install sfnt2woff
#brew install sfnt2woff-zopfli
#brew install woff2

## Install some fonts
brew tap homebrew/cask-fonts
brew install --cask font-source-code-pro

# Install some CTF tools; see https://github.com/ctfs/write-ups.
#brew install aircrack-ng
#brew install bfg
#brew install binutils
#brew install binwalk
#brew install cifer
#brew install dex2jar
#brew install dns2tcp
#brew install fcrackzip
#brew install foremost
#brew install hashpump
#brew install hydra
#brew install john
#brew install knock
#brew install netpbm
brew install nmap
#brew install pngcheck
#brew install socat
#brew install sqlmap
#brew install tcpflow
#brew install tcpreplay
#brew install tcptrace
#brew install ucspi-tcp # `tcpserver` etc.
#brew install xpdf
#brew install xz

# Install other useful binaries.
#brew install ack
#brew install exiv2
#brew install git
#brew install git-lfs
#brew install gs
#brew install imagemagick --with-webp
#brew install lua
#brew install lynx
brew install p7zip
#brew install pigz
#brew install pv
#brew install rename
#brew install rlwrap
#brew install ssh-copy-id
brew install tree
#brew install vbindiff
#brew install zopfli
brew install dockutil
brew install wifi-password


# Wait a bit before moving on...
sleep 1

# ...and then.
echo "Success! Basic brew packages are installed."

# Install cask packages
brew install --cask --appdir="/Applications" microsoft-outlook
brew install --cask --appdir="/Applications" microsoft-teams
brew install --cask --appdir="/Applications" 1password
brew install --cask --appdir="/Applications" alfred
brew install --cask --appdir="/Applications" bettertouchtool
brew install --cask --appdir="/Applications" bbedit
#brew install --cask --appdir="/Applications" filemaker-pro
brew install --cask --appdir="/Applications" the-unarchiver
brew install --cask --appdir="/Applications" iterm2
brew install --cask --appdir="/Applications" slack
#brew install --cask --appdir="/Applications" google-chrome
#brew install --cask --appdir="/Applications" firefox
#brew install --cask --appdir="/Applications" spectacle
brew install --cask --appdir="/Applications" betterzip
brew install --cask --appdir="/Applications" suspicious-package
brew install --cask --appdir="/Applications" apparency
brew install --cask --appdir="/Applications" autopkgr
brew install --cask --appdir="/Applications" munkiadmin


# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew install --cask qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv qlimagesize webpquicklook qlvideo
xattr -d -r com.apple.quarantine ~/Library/QuickLook


# Remove outdated versions from the cellar.
brew cleanup

echo "setup/brew.sh done Homebrewing"

