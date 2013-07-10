#!/bin/bash

# Determine which machine we are on
if [[ $NERSC_HOST == "pdsf" ]]; then
	extension=".ext"
fi

if [[ ! -d "$HOME/.dotFilesBak" ]]; then
	mkdir "$HOME/.dotFilesBak"
fi

# .bashrc
echo ".bashrc"
if [[ -e "$HOME/.bashrc$extension" ]]; then
	mv "$HOME/.bashrc$extension" "$HOME/.dotFilesBak/.bashrc$extension"
fi
ln -s "$PWD/.bashrc" "$HOME/.bashrc$extension"

source "$HOME/.bashrc"

# .gitconfig
echo ".gitconfig"
if [[ -e "$HOME/.gitconfig" ]]; then
	mv "$HOME/.gitconfig" "$HOME/.dotFilesBak/.gitconfig"
fi
ln -s "$PWD/.gitconfig" "$HOME/.gitconfig"

# .rootrc
echo ".rootrc"
if [[ -e "$HOME/.rootrc" ]]; then
	mv "$HOME/.rootrc" "$HOME/.dotFilesBak/.rootrc"
fi
ln -s "$PWD/.rootrc" "$HOME/.rootrc"

# .screenrc
echo ".screenrc"
if [[ -e "$HOME/.screenrc" ]]; then
	mv "$HOME/.screenrc" "$HOME/.dotFilesBak/.screenrc"
fi
ln -s "$PWD/.screenrc" "$HOME/.screenrc"

# .tmux.conf
echo ".tmux.conf"
if [[ -e "$HOME/.tmux.conf" ]]; then
	mv "$HOME/.tmux.conf" "$HOME/.dotFilesBak/.tmux.conf"
fi
ln -s "$PWD/.tmux.conf" "$HOME/.tmux.conf"

# atlasStyle.h
echo "Installing root style"
if [[ -e "$MYINSTALL/include/atlasStyle.h" ]]; then
	mv "$MYINSTALL/include/atlasStyle.h" "$HOME/.dotFilesBak/atlasStyle.h"
fi
ln -s "$PWD/atlasStyle.h" "$MYINSTALL/include/atlasStyle.h"

# .vim folder
echo ".vim folder"
if [[ -e "$HOME/.vim" ]]; then
	mv "$HOME/.vim" "$HOME/.dotFilesBak/.vim"
fi
ln -s "$PWD/.vim" "$HOME/.vim"

# .vimrc
echo ".vimrc"
if [[ -e "$HOME/.vimrc" ]]; then
	mv "$HOME/.vimrc" "$HOME/.dotFilesBak/.vimrc"
fi
ln -s "$PWD/.vim/.vimrc" "$HOME/.vimrc"
