#!/bin/bash

# The two arguments are name and location
function installFiles()
{
	# Note which file is being installed
	echo "$1"

	# Setup variables
	file="$1"
	location="$2/$file"
	if [[ -z "$3" ]]; then
		comparisonValue="$PWD/$file"
	else
		comparisonValue="$PWD/$3"
		file="$3"
	fi

	# Test if it is a symlink
	if [[ ! -L "$location" ]]; then
		# Test if it exists already
		if [[ -e "$location" ]]; then
			mv "$location" "$HOME/.dotFilesBak/"
		fi
		ln -s "$PWD/$file" "$location"
		echo -e "\tInstalled symlink"
	else
		symlinkValue=$(readlink "$location")
		if [[ "$symlinkValue" == "$comparisonValue" ]]; then
			echo -e "\tSymlink already setup with correct value"
		else
			echo -e "\tWARNING: Symlink is present, but the value is not correct. Figure this out. Leaving the symlink in place"
		fi
	fi
}

# Determine which machine we are on. If on pdsf, include .ext extension for bashrc
if [[ "$NERSC_HOST" == "pdsf" ]]; then
	extension=".ext"
fi

if [[ ! -e ".gitconfig" || ! -e ".ssh/config" || ! -e "serverAliases.sh" ]];
then
    echo "Please create .gitconfig, .ssh/config, and serverAliases.sh and then rerun."
    exit 1
fi

# Create backup location if necessary
if [[ ! -d "$HOME/.dotFilesBak" ]]; then
	mkdir "$HOME/.dotFilesBak"
else
	echo -e "\tThere are already backup files. Please move or remove them, and run again"
	exit 1
fi

# .bashrc
installFiles ".bashrc$extension" "$HOME" ".bashrc"
source "$HOME/.bashrc$extension"

# .gitconfig
installFiles ".gitconfig" "$HOME"

# .rootrc
installFiles ".rootrc" "$HOME"

# .screenrc
installFiles ".screenrc" "$HOME"

# .tmux.conf
installFiles ".tmux.conf" "$HOME"

# .tmux-osx.conf
installFiles ".tmux-osx.conf" "$HOME"

# .ackrc
installFiles ".ackrc" "$HOME"

# .ctags
installFiles ".ctags" "$HOME"

# rootLogon.h 
installFiles "rootLogon.h" "$MYINSTALL/rootMacros"

# retreiveObjects.h 
installFiles "retreiveObjects.h" "$MYINSTALL/rootMacros"

# readableStyle.h
installFiles "readableStyle.h" "$MYINSTALL/include"

# .vim folder
installFiles ".vim" "$HOME"

# .vimrc
installFiles ".vimrc" "$HOME" ".vim/.vimrc"

# .ssh config
installFiles "config" "$HOME/.ssh" ".ssh/config"

# createNewProject (c++)
if [[ $(uname -s) == "Darwin" ]];
then
    sedExecutableName="gsed"
else
    sedExecutableName="sed"
fi
$sedExecutableName --in-place=.bak -e "s|\(localPathName=\)\"[0-9a-zA-Z/.]*\"|\1\"$PWD\/createNewProject\"|" createNewProject/createNewProject.sh
installFiles "newCppProject" "$MYINSTALL/bin" "createNewProject/createNewProject.sh"

# Remove .dotFilesBak if it is empty
if find "$HOME/.dotFilesBak" -maxdepth 0 -empty | read; then
	rmdir "$HOME/.dotFilesBak"
fi

