
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

notifyDone()
{
    if [[ -n "$1" ]]; then
        # Take the message that was passed in.
        message="$1"
    else
        # Support piping in the message.
        message=""
        while read data; do
            if [[ -n "${message}" ]]; then
                message=", ${message}"
            else
                message="${data}"
            fi
        done
    fi
    terminal-notifier -title "Job done" -message "${message}" -activate "com.googlecode.iterm2" -sound Purr
}

# Setup install area
export MYINSTALL="${HOME}/install"
# And create the necessary directories.
for dirName in "${MYINSTALL}" "${MYINSTALL}/bin" "${MYINSTALL}/include" "${MYINSTALL}/lib" "${MYINSTALL}/rootMacros"; do
    if [[ ! -d "${dirName}" ]]; then
        mkdir "${dirName}"
    fi
done

# Setup PATH, LD_LIBRARY_PATH, Man PATH as necessary
# These functions replace direct redefinitions of these variables
addToLDLibraryPath "${MYINSTALL}/lib"
addToPath "${MYINSTALL}/bin"
addToManPath "${MYINSTALL}/share/man"
# To support homebrew on Mac.
if [[ $(uname -s) == "Darwin" ]]; then
    addToLDLibraryPath "/usr/local/lib"
    addToPath "/usr/local/bin"
    addToPath "/usr/local/sbin"
    # Needed for ALICE software
    addToPath "/usr/local/opt/gettext/bin"
fi

# Language specific setup
# Python
# Add bin for pip packages installed with `--user`
pythonUserPrefix="$(python3 -m site --user-base)"
addToPath "${pythonUserPrefix}/bin"
# Pyenv
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
# Poetry
addToPath "${HOME}/.poetry/bin"

# Options
# General
export EDITOR="vim"
# zsh
# Do not store duplications
setopt HIST_IGNORE_DUPS
# Enable vi key bindings
bindkey -v
# Add a few more keybindings for convenience (ie. emacs ones which I'm used to).
# NOTE: The bindings themselves don't appear to be case sensitive.
# ctrl-r for reverse search
bindkey '^R' history-incremental-search-backward
# ctrl-a to jump to the start of the line
bindkey '^A' vi-beginning-of-line
# ctrl-e to jump to the end of the line.
bindkey '^E' vi-end-of-line
# ls
# Options for ls:
#   -l is long,
#   -h is human readable sizes,
#   -X is ordered by file type (ie alphabetical by folder, then file, etc),
#   -F adds additional decoration (/ after folder, * after executable, @ after symlinks, etc)
lsColorOptions="--color=auto"
lslOptions="-lhXF"
lsaOptions="-a"
# Need to handle macOS vs Linux separately.
if [[ $(uname -s) == "Darwin" ]]; then
    # Enables color in the terminal
    export CLICOLORS=1
    alias ls="ls -FG"

    # Define useful aliases using coreutils
    alias gls="gls $lsColorOptions"
    alias lsl="gls $lslOptions"
    alias lsa="lsl $lsaOptions"
else
    # Only assign to ls on linux!
    alias ls="ls $lsColorOptions"
    alias lsl="ls $lslOptions"
    alias lsa="lsl $lsaOptions"
fi

# OS specific options
# macOS
if [[ $(uname -s) == "Darwin" ]]; then
    # Enable installed zsh completion files
    if [ -f $(brew --prefix)/etc/zsh_completion ]; then
        source $(brew --prefix)/etc/zsh_completion
    fi

    # Setup GPG and keychain integration
    # From: https://medium.com/@timmywil/sign-your-commits-on-github-with-gpg-566f07762a43
    if [ -f ~/.gnupg/.gpg-agent-info  ] && [ -n "$(pgrep gpg-agent)" ]; then
        source ~/.gnupg/.gpg-agent-info
        export GPG_AGENT_INFO
    else
        eval $(gpg-agent --daemon)
    fi
fi

# Change the PS1 if we are not on linux mint
if [[ ! -f /etc/lsb-release || ! $(cat /etc/lsb-release | grep -i "mint") ]]; then
    # Set prompt
    # Custom prompt from https://www.kirsle.net/wizards/ps1.html.
    # Adapted from bash to zsh.
    export PROMPT="%B%F{green}[%T] %n@%m %F{blue}%4~ $ %f%b"
fi

# Aliases
# Poetry. See https://github.com/sdispater/poetry/issues/571#issuecomment-473438295
alias poetryShell='source "$(poetry env info --path)/bin/activate"'
# Tmux
alias tmux="tmux -2"
alias tm="tmux attach-session || tmux new"
# Vim
# Use nvim implace of vim when available.
if [[ -n "$(which nvim &> /dev/null)" ]];
then
    alias vim="nvim"
fi
# Use vim for syntax highlighting in less. This find should probably be perofmred more
# carefully, but it is fine for now, as I use less much less now
VLESS=$(find /usr/share/vim -name 'less.sh')
if [[ ! -z $VLESS ]]; then
    alias less=$VLESS
fi
# git / hub
if [[ -n "$(which hub)" ]];
then
    alias git="hub"
fi
# ROOT
alias root="root -l"
alias rootb="root -l -b -q"

# ALICE specific settings
export alien_API_USER="rehlersi"
# For aliBuild
export ALIBUILD_WORK_DIR="${HOME}/alice/sw"
if [[ -n "$(which alienv &> /dev/null)" ]];
then
    # Load environment helper
    eval "`alienv shell-helper`"
fi
# Define the ALICE_DATA variable so OADB files can be found on CVMFS.
# We define this in a function so that it's evaluated when called (so it can update the current shell)
aliceData()
{
    d=date;
    if [[ -n "$(which gdate &> /dev/null)" ]];
    then
        d=gdate;
    fi
    # We ideally want yesterday's date because today's tag many not yet be available.
    # For getting that date, see https://stackoverflow.com/a/15374813
    export ALICE_DATA="/cvmfs/alice.cern.ch/data/analysis/$($d +%Y)/vAN-$($d -d 'yesterday 13:00' '+%Y%m%d')/"
}

# Add git zsh completion. Apparently it's rather different than bash...
autoload -U compinit && compinit
zmodload -i zsh/complist

# added by travis gem
[ -f /Users/re239/.travis/travis.sh ] && source /Users/re239/.travis/travis.sh
