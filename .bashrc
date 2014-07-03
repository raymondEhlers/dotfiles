# .bashrc

# Functions
# Inspired by http://superuser.com/a/39995 
addToEnvironmentVariables()
{
	if [[ -d "$1" ]] && [[ ":$2:" != *":$1:"* ]]; then
		echo "$1:$2"
	else
		echo "$2"
	fi
}

addToPath()
{
	PATH=$(addToEnvironmentVariables "$1" "$PATH")
}

addToLDLibraryPath()
{
	LD_LIBRARY_PATH=$(addToEnvironmentVariables "$1" "$LD_LIBRARY_PATH")
}

addToManPath()
{
	MANPATH=$(addToEnvironmentVariables "$1" "$MANPATH")
}

lpdf()
{
	if [[ -n "$1" ]]; then
		lesspipe "$1" | less
	else
		echo "Please select a pdf file to open"
	fi
}

# Adapted from: http://readystate4.com/2011/03/31/refresh-a-stale-tmux-session/
refreshTmuxDisplay()
{
	if [[ -n $TMUX ]]; then
		newDisplay=$(tmux showenv | grep "^DISPLAY" | cut -d = -f 2)
		if [[ -n "$newDisplay" ]] && [[ "$DISPLAY" != "$newDisplay" ]]; then
			DISPLAY="$newDisplay"
			echo "Display changed to $DISPLAY"
		fi
	fi
}

# Configuration
if [[ $NERSC_HOST == "pdsf" ]]; then
	# ALICE
	module use /project/projectdirs/alice/software/modulefiles/
	
	# tools
	module load subversion
	module load cmake
	module load git

	# I don't know exactly why this needs to be done, but it was in Megan's
	# .bashrc. Therefore, I assume that it is needed for linking
	if [[ $LD_LIBRARY_PATH != *$ALICE/objdir/lib* ]]; then
		export LD_LIBRARY_PATH=$ALICE/objdir/lib/tgt_$ALICE_TARGET:$LD_LIBRARY_PATH
	fi

	# Useful variables
	export PROJECTDIR="/project/projectdirs/alice/rehlers/"

	# Customize the prompt
	DEFAULTCOLOR="\[\033[0;0m\]"
	CYAN="\[\033[0;36m\]"

	export PS1="$DEFAULTCOLOR[\u@\h $CYAN\w] $DEFAULTCOLOR\$ "
fi

if [[ -z "$NERSC_HOST" ]]; then
	# Source global definitions
	if [ -f /etc/bashrc ]; then
		. /etc/bashrc
	fi

	# Setup ROOT if necessary (ony works on the ATLAS cluster)
	if [[ -e "$HOME/setup_root.sh" ]]; then
		source "$HOME/setup_root.sh"
	fi

	# Check if Git is installed locally. If so, add to the path before MYINSTALL
	if [[ -d "$MYINSTALL/git/bin" ]]; then
		addToPath "$MYINSTALL/git/bin"
	fi
fi

# Setup install area 
export MYINSTALL="$HOME/install"

# Create ~/install directory if necessary
if [[ ! -d "$MYINSTALL" ]]; then
	mkdir "$MYINSTALL"
fi

# When make install is run, it appears to make the necessary folders. However, include is necessary, as I install files there
if [[ ! -d "$MYINSTALL/include" ]]; then
	mkdir "$MYINSTALL/include"
fi

# Same for rootMacros
if [[ ! -d "$MYINSTALL/rootMacros" ]]; then
	mkdir "$MYINSTALL/rootMacros"
fi

# These functions replace direct redefinitions of these variables
addToLDLibraryPath "$MYINSTALL/lib"
addToPath "$MYINSTALL/bin"
addToManPath "$MYINSTALL/share/man"

# User specific aliases and functions
alias ls="ls --color=auto"
alias lsl="ls -lhX"
alias lsa="lsl -a"
alias root="root -l"
alias rootb="root -l -b -q"
alias timeRoot="/usr/bin/time -v -a -o time.log root -l -b -q"
alias screen="screen -xR"
alias tmux="tmux -2"
alias tm="tmux attach-session || tmux new"
# Experiment specific
#if [[ -d "$MYINSTALL/alice" ]] || [[ -d "/opt/alice" ]]; then
if [[ -e "$HOME/code/alice/aliceSetup/alice-env.sh" ]]; then
	alias setupAlice="source $HOME/code/alice/aliceSetup/alice-env.sh -n";
fi

# Use vim for syntax highlighting in less
# This find should probably be perofmred more carefully, but it is fine for now, as I use less much less now
VLESS=$(find /usr/share/vim -name 'less.sh')
if [[ ! -z $VLESS ]]; then
	alias less=$VLESS
fi

# Remote history duplicates
export HISTCONTROL=ignoredups

# Useful variables
export EDITOR="vim"
export alien_API_USER="rehlersi"

# Expand tab completion without adding an extra '\' in bash 4
# See:  http://askubuntu.com/a/318746
if [[ $BASH_VERSINFO == 4 ]]; then
	shopt -s direxpand
fi

# This has to be in a different function. If not, the alias will not yet be defined...
if [[ -e "$HOME/code/alice/aliceSetup/alice-env.sh" ]]; then
	setupAlice -q

	# If I am running this, I almost certainly need fastjet, so they should be added to PATH and LD_LIBRARY_PATH
	#export FASTJET="$MYINSTALL/alice/fastjet"
	#addToPath "$FASTJET/bin"
	#addToLDLibraryPath "$FASTJET/lib"
fi

# Create OCDB variable necessary for proper usage of testtrain.sh
if [[ -d "$HOME/code/alice/data/OCDB" ]]; then
	export ALICE_OCDB="$HOME/code/alice/data/OCDB"
fi
