# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Setup install area for automake
export MYINSTALL=~/install
export LD_LIBRARY_PATH="$MYINSTALL/lib":$LD_LIBRARY_PATH

# Check if Git is installed locally. If so, add it to the path before MYINSTALL
if [[ -d "$MYINSTALL/git/bin" ]]; then
	export PATH="$MYINSTALL/git/bin":$PATH
fi
export PATH="$MYINSTALL/bin":$PATH

# User specific aliases and functions
alias lsl="ls -lhX"
alias root="root -l"
alias rootb="root -l -b -q"
alias timeroot="/usr/bin/time -v -a -o time.log root -l -b -q"
alias screen="screen -xR"
alias screenNew="screen"

# Use vim for syntax highlighting in less
VLESS=$(find /usr/share/vim -name 'less.sh')
if [ ! -z $VLESS ]; then
	alias less=$VLESS
fi

# Remote history duplicates
export HISTCONTROL=ignoredups
