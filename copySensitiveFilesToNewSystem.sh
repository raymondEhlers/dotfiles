#!/usr/bin/env bash
# Copy sensitive files
# Current sensitive files are:
#  .ssh/config
#  serverAliases.sh
#  .gitconfig

if [[ -z "$1" ]];
then
    echo "Please pass user@hostname for the copy to take place"
    exit 1
fi

echo "Copying to $1"

scp "$HOME/.dotfiles/.ssh/config" "$1:~/.dotfiles/.ssh/."
scp "$HOME/.dotfiles/serverAliases.sh" "$1:~/.dotfiles/."
scp "$HOME/.dotfiles/.gitconfig" "$1:~/.dotfiles/."
