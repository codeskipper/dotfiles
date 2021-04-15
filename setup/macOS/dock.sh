#!/usr/bin/env bash

echo "setup/dock.sh Setting up your Dock"

# Set the icon size of Dock items to 35 pixels
defaults write com.apple.dock tilesize -int 35

# Set the dock to NOT autohide
defaults write com.apple.Dock autohide 0

# Set the dock autohide delay to 0
defaults write com.apple.Dock autohide-delay -float 0.5

dockutil --no-restart --remove all
dockutil --no-restart --add "/System/Applications/Launchpad.app"
dockutil --no-restart --add "/System/Applications/Messages.app"
dockutil --no-restart --add "/Applications/Safari.app"
dockutil --no-restart --add "/Applications/Microsoft Outlook.app"
dockutil --no-restart --add "/Applications/Microsoft Teams.app"
#dockutil --no-restart --add "/Applications/Firefox.app"
#dockutil --no-restart --add "/Applications/Google Chrome.app"
#dockutil --no-restart --add "/Applications/Sourcetree.app"
[[ -e "/Applications/BBEdit.app" ]] && dockutil --no-restart --add "/Applications/BBEdit.app"
[[ -e "/Applications/Visual Studio Code.app" ]] && dockutil --no-restart --add "/Applications/Visual Studio Code.app"

dockutil --no-restart --add "/Applications/Slack.app"
#dockutil --no-restart --add "/System/Applications/Calendar.app"
dockutil --no-restart --add "/System/Applications/Utilities/Terminal.app"
[[ -e /Applications/Privileges.app ]] && dockutil --no-restart --add "/Applications/Privileges.app"
dockutil --no-restart --add "~/Downloads"

killall Dock

echo "setup/dock.sh done setting up your Dock."
