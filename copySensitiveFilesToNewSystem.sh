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

echo "Copying from $1"

scp "$1:~/.dotfiles/.ssh/config" "$HOME/.dotfiles/.ssh/." 
scp "$1:~/.dotfiles/serverAliases.sh" "$HOME/.dotfiles/."
scp "$1:~/.dotfiles/.gitconfig" "$HOME/.dotfiles/."
