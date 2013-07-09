# .bashrc

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
	export alien_API_USER="rehlers"
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

	# Setup ROOT if necessary
	if [[ -e "$HOME/setup_root.sh" ]]; then
		source "$HOME/setup_root.sh"
	fi

	# Check if Git is installed locally. If so, add to the path before MYINSTALL
	if [[ -d "$MYINSTALL/git/bin" ]]; then
		export PATH="$MYINSTALL/git/bin":$PATH
	fi
fi

# Create ~/install directory if necessary
if [[ ! -d "$HOME/install" ]]; then
	mkdir "$HOME/install"
	mkdir "$HOME/install/include"
	mkdir "$HOME/install/lib"
	mkdir "$HOME/install/bin"
fi

# Setup install area 
export MYINSTALL="$HOME/install"
export LD_LIBRARY_PATH="$MYINSTALL/lib":$LD_LIBRARY_PATH
export PATH="$MYINSTALL/bin":$PATH

# User specific aliases and functions
alias ls="ls --color=auto"
alias lsl="ls -lhX"
alias lsa="lsl -a"
alias root="root -l"
alias rootb="root -l -b -q"
alias timeroot="/usr/bin/time -v -a -o time.log root -l -b -q"
alias screen="screen -xR"
alias screenNew="screen"

# Use vim for syntax highlighting in less
# This find should probably be perofmred more carefully, but it is fine for now
VLESS=$(find /usr/share/vim -name 'less.sh')
if [[ ! -z $VLESS ]]; then
	alias less=$VLESS
fi

# Remote history duplicates
export HISTCONTROL=ignoredups

# Useful variables
export EDITOR="vim"
