# .bashrc

. "$HOME/.dotfiles/serverAliases.sh"

# Functions
# Inspired by http://superuser.com/a/39995 
addToEnvironmentVariables()
{
    if [[ -z "$2" ]];
    then
        # Incase the variable being passed is not defined.
        # Should be rather rare
        echo "$1"
    else
        if [[ -d "$1" ]] && [[ ":$2:" != *":$1:"* ]]; then
            echo "$1:$2"
        else
            echo "$2"
        fi
    fi
}

addToPath()
{
    PATH=$(addToEnvironmentVariables "$1" "$PATH")
}

addToLDLibraryPath()
{
    #echo "Before: $1 to $LD_LIBRARY_PATH"
    #echo $(addToEnvironmentVariables "$1" "$LD_LIBRARY_PATH")
    LD_LIBRARY_PATH=$(addToEnvironmentVariables "$1" "$LD_LIBRARY_PATH")
    #echo "After: $1 to $LD_LIBRARY_PATH"
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
    #module use /project/projectdirs/alice/software/modulefiles/

    # tools
    #module load subversion
    #module load cmake
    #module load git

    # I don't know exactly why this needs to be done, but it was in Megan's
    # .bashrc. Therefore, I assume that it is needed for linking
    if [[ $LD_LIBRARY_PATH != *$ALICE/objdir/lib* ]]; then
        export LD_LIBRARY_PATH=$ALICE/objdir/lib/tgt_$ALICE_TARGET:$LD_LIBRARY_PATH
    fi

    # Useful variables
    export PROJECTDIR="/project/projectdirs/alice/rehlers/"

    # Customize the prompt
    #DEFAULTCOLOR="\[\033[0;0m\]"
    #CYAN="\[\033[0;36m\]"
    #export PS1="$DEFAULTCOLOR[\u@\h $CYAN\w] $DEFAULTCOLOR\$ "
    export PS1="\[$(tput bold)\]\[$(tput setaf 2)\]\u@\h \[$(tput setaf 4)\]\w \\$ \[$(tput sgr0)\]"
fi

# Setup install area
export MYINSTALL="$HOME/install"

if [[ -z "$NERSC_HOST" ]]; then
    # Source global definitions
    if [ -f /etc/bashrc ]; then
        . /etc/bashrc
    fi

    # Setup ROOT if necessary (ony works on the ATLAS cluster)
    if [[ -e "$HOME/setup_root.sh" ]]; then
        source "$HOME/setup_root.sh"
    fi

    # Check if Git is installed locally. If so, add to the path
    if [[ -d "$MYINSTALL/git/bin" ]]; then
        addToPath "$MYINSTALL/git/bin"
    fi
fi

# Create ~/install directory if necessary
if [[ ! -d "$MYINSTALL" ]]; then
    mkdir "$MYINSTALL"
fi

# When make install is run, it appears to make the necessary folders. However, include is necessary, as I install files there
if [[ ! -d "$MYINSTALL/include" ]]; then
    mkdir "$MYINSTALL/include"
fi

# bin is also necessary
if [[ ! -d "$MYINSTALL/bin" ]]; then
    mkdir "$MYINSTALL/bin"
fi

# Same for lib
if [[ ! -d "$MYINSTALL/lib" ]]; then
    mkdir "$MYINSTALL/lib"
fi

# Same for rootMacros
if [[ ! -d "$MYINSTALL/rootMacros" ]]; then
    mkdir "$MYINSTALL/rootMacros"
fi

# These functions replace direct redefinitions of these variables
addToLDLibraryPath "$MYINSTALL/lib"
addToPath "$MYINSTALL/bin"
addToManPath "$MYINSTALL/share/man"

# To support homebrew on Mac. It is fine on linux
addToLDLibraryPath "/usr/local/lib"
addToPath "/usr/local/bin"
addToPath "/usr/local/sbin"

# Setup GO lang
export GOPATH=$HOME/.go
#addToPath "$GOPATH/bin"

# User specific aliases and functions
# -l is long, -h is human readable sizes, -X is ordered by file type (ie alphabetical by folder, then file, etc), F adds additional decoration (/ after folder, * after executable, @ after symlinks, etc)
lsColorOptions="--color=auto"
lslOptions="-lhXF"
lsaOptions="-a"
# Check if on a Mac
if [[ $(uname -s) == "Darwin" ]];
then
    # Enables color in the terminal
    export CLICOLORS=1
    alias ls="ls -FG"

    # Define useful aliases using coreutils
    alias gls="gls $lsColorOptions"
    alias lsl="gls $lslOptions"
    alias lsa="lsl $lsaOptions"

    # Enable installed bash completion files
    if [ -f $(brew --prefix)/etc/bash_completion  ]; then
        source $(brew --prefix)/etc/bash_completion
    fi

    # Setup GPG and keychain integration
    # From: https://medium.com/@timmywil/sign-your-commits-on-github-with-gpg-566f07762a43
    if [ -f ~/.gnupg/.gpg-agent-info  ] && [ -n "$(pgrep gpg-agent)"  ]; then
        source ~/.gnupg/.gpg-agent-info
        export GPG_AGENT_INFO
    else
        eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
    fi
else
    # Only assign to ls on linux!
    alias ls="ls $lsColorOptions"
    alias lsl="ls $lslOptions"
    alias lsa="lsl $lsaOptions"
fi

# Change the PS1 if we are not on linux mint
if [[ ! -f /etc/lsb-release || ! $(cat /etc/lsb-release | grep -i "mint") ]]; then
    # Set prompt
    # Custom bash prompt from kirsle.net/wizards/ps1.html
    export PS1="\[$(tput bold)\]\[$(tput setaf 2)\]\u@\h \[$(tput setaf 4)\]\w \\$ \[$(tput sgr0)\]"
fi

alias root="root -l"
alias rootb="root -l -b -q"
alias timeRoot="/usr/bin/time -v -a -o time.log root -l -b -q"
alias screen="screen -xR"
alias tmux="tmux -2"
alias tm="tmux attach-session || tmux new"
alias fuck='eval $(thefuck $(fc -ln -1)); history -r'
# Weekly alias
alias shit='fuck'
# Experiment specific
if [[ -e "$HOME/aliceSW/alice-env.sh" ]]; then
    alias ali="source $HOME/aliceSW/alice-env.sh -n 1";
fi
# For aliBuild
export ALICE_WORK_DIR="$HOME/alice/sw"
if [[ -n "$(which alienv)" ]];
then
    # Load environment helper
    eval "`alienv shell-helper`"
fi
alias buildRoot5="aliBuild -z root5 -w ${ALICE_WORK_DIR} --defaults release --disable GEANT3,GEANT4_VMC build AliPhysics"
alias buildRoot6="aliBuild -z root6 -w ${ALICE_WORK_DIR} --defaults root6 --disable GEANT3,GEANT4_VMC build AliPhysics"
# Setup hub
if [[ -n "$(which hub)" ]];
then
    alias git=hub
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
# See: http://askubuntu.com/a/318746
if [[ $BASH_VERSINFO == 4 ]]; then
    shopt -s direxpand
fi

# This has to be in a different function. If not, the alias will not yet be defined...
# Only do this if aliBuild is not installed. Otherwise, it will interfere
if [[ -e "$HOME/aliceSW/alice-env.sh" && -z "$(which alienv)" ]]; then
    echo "Running alice-env.sh"
    ali -q
fi

# Create OCDB variable necessary for proper usage of testtrain.sh
if [[ -d "$HOME/code/alice/data/OCDB" ]]; then
    export ALICE_OCDB="$HOME/code/alice/data/OCDB"
fi
