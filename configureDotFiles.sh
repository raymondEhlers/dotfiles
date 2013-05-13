#!/bin/bash
if [[ ! -d "$HOME/.dotFilesBak" ]]; then
	mkdir "$HOME/.dotFilesBak"
fi

# .bashrc
if [[ -e "$HOME/.bashrc" ]]; then
	mv "$HOME/.bashrc" "$HOME/.dotFilesBak/.bashrc"
fi
ln -s "$PWD/.bashrc" "$HOME/.bashrc"

source "$HOME/.bashrc"

# .gitconfig
if [[ -e "$HOME/.gitconfig" ]]; then
	mv "$HOME/.gitconfig" "$HOME/.dotFilesBak/.gitconfig"
fi
ln -s "$PWD/.gitconfig" "$HOME/.gitconfig"

# .rootrc
if [[ -e "$HOME/.rootrc" ]]; then
	mv "$HOME/.rootrc" "$HOME/.dotFilesBak/.rootrc"
fi
ln -s "$PWD/.rootrc" "$HOME/.rootrc"

# .screenrc
if [[ -e "$HOME/.screenrc" ]]; then
	mv "$HOME/.screenrc" "$HOME/.dotFilesBak/.screenrc"
fi
ln -s "$PWD/.screenrc" "$HOME/.screenrc"

# atlasStyle.h
if [[ -e "$MYINSTALL/include/atlasStyle.h" ]]; then
	mv "$MYINSTALL/include/atlasStyle.h" "$HOME/.dotFilesBak/atlasStyle.h"
fi
ln -s "$PWD/atlasStyle.h" "$MYINSTALL/include/atlasStyle.h"

# .vim folder
if [[ -e "$HOME/.vim" ]]; then
	mv "$HOME/.vim" "$HOME/.dotFilesBak/.vim"
fi
ln -s "$PWD/.vim" "$HOME/.vim"

# .vimrc
if [[ -e "$HOME/.vimrc" ]]; then
	mv "$HOME/.vimrc" "$HOME/.dotFilesBak/.vimrc"
fi
ln -s "$PWD/.vim/.vimrc" "$HOME/.vimrc"
