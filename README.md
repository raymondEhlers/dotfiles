This repo covers my dotfiles. It is nothing special

To update and utilize submodules
========
see: http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
To utilize:
	In the repo root:
		git submodule update --init

To update:
	In the repo root:
		git submodule foreach git pull origin master
