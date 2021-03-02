
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
    # Extract command name like this:
    #alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
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
# Pyenv (must go before retrieving the user-base path)
export PYENV_ROOT="$HOME/.pyenv"
addToPath "${PYENV_ROOT}/bin"
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init -)"
fi
# Add bin for pip packages installed with `--user`
pythonUserPrefix="$(python3 -m site --user-base)"
addToPath "${pythonUserPrefix}/bin"
# Poetry
addToPath "${HOME}/.poetry/bin"
# Go
# It's fairly likely that go will be installed in /usr/local/go, so we assume that here.
addToPath "/usr/local/go/bin"

# Options
# General
export EDITOR="vim"
# zsh
# history options
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY
# Do not store duplications
setopt HIST_IGNORE_ALL_DUPS
# Enable vi key bindings
bindkey -v
# Add a few more key bindings for convenience (ie. emacs ones which I'm used to).
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
if command -v nvim &> /dev/null; then
    alias vim="nvim"
fi
# Use vim for syntax highlighting in less. This find should probably be performed more
# carefully, but it is fine for now, as I use less much less now
VLESS=$(find /usr/share/vim -name 'less.sh')
if [[ ! -z $VLESS ]]; then
    alias less=$VLESS
fi
# git / hub
if command -v hub &> /dev/null; then
    alias git="hub"
fi
# ROOT
alias root="root -l"
alias rootb="root -l -b -q"

# ALICE specific settings
export alien_API_USER="rehlersi"
# For aliBuild
export ALIBUILD_WORK_DIR="${HOME}/alice/sw"
if command -v alienv &> /dev/null; then
    # Load environment helper
    eval "`alienv shell-helper`"
fi
# If we're on Debian, we always need to set the architecture. So we redefine the aliBuild and alienv
# commands when appropriate. For now, we'll grab the architecture name from the AliBuild dir so we
# don't have to map names to Ubuntu versions.
if command -v lsb_release &> /dev/null; then
    if [[ "Debian" == "$(lsb_release -si)" ]]; then
        additionalOptions=""
        for p in ${ALIBUILD_WORK_DIR}/*; do
            # We want just the dir name, not the whole path
            d=$(basename ${p})
            if [[ "${d}" ==  *"ubuntu"* ]]; then
                # Once we've found the architecture, we can continue.
                # There will be only one Ubuntu directory.
                additionalOptions="--architecture ${d}"
                break
            fi
        done
        if [[ ! -z "${additionalOptions}" ]]; then
            # NOTE: If we are defining alienv with the architecture not using this alias, then we need to
            #       explicitly split the arguments using the "=" option: ie. ${=additionalOptions}. This is
            #       the opposite of bash.
            alias aliBuild="aliBuild ${additionalOptions}"
            alias alienv="alienv ${additionalOptions}"
        fi
    fi
fi
# Define the ALICE_DATA variable so OADB files can be found on CVMFS.
# We define this in a function so that it's evaluated when called (so it can update the current shell)
aliceData()
{
    d=date;
    if command -v gdate &> /dev/null; then
        d=gdate;
    fi
    # We ideally want yesterday's date because today's tag many not yet be available.
    # For getting that date, see https://stackoverflow.com/a/15374813
    export ALICE_DATA="/cvmfs/alice.cern.ch/data/analysis/$($d +%Y)/vAN-$($d -d 'yesterday 13:00' '+%Y%m%d')/"
}
# Helper for using AliBuild with pyenv on linux.
# It should also work on macOS, but it isn't required.
aliload()
{
    # Specify AliPhysics as the default version
    version="AliPhysics/latest"
    if [[ -n "$@" ]]; then
        version="$@"
    fi
    # Load the environment
    # alienv (more likely modulecmd) will only sometimes report what is being loaded, so we do
    # it ourselves to be certain that we'll know what was done.
    echo "Loading ${version}..."
    eval `alienv modulecmd zsh load "${=version}"`
    # Work around missing python library (due to AliBuild bug?? Unclear). It seems likely that
    # it's due to AliBuild ignoring the rpath specified in python on linux (but it follows it
    # on macOS). In any case, we can resolve it by adding explicitly to the LD_LIBRARY_PATH.
    # NOTE: This requires the AliPhysics ctests to be disabled because it won't load the modified
    #       LD_LIBRARY_PATH for the tests, which means it won't suceed on the first AliBuild build.
    if [[ $(uname -s) != "Darwin" ]]; then
        # Change to the AliBuild directory to ensure that we pick up the right python version
        # By using `-q`, this change should happen quietly.
        pushd -q ${ALIBUILD_WORK_DIR}
        pythonVersion=$(pyenv version-name)
        #echo "python version: ${pythonVersion}"
        addToLDLibraryPath "${PYENV_ROOT}/versions/${pythonVersion}/lib"
        popd -q
    fi
}

# Add git zsh completion. Apparently it's rather different than bash...
autoload -U compinit && compinit
zmodload -i zsh/complist

# added by travis gem
[ -f /Users/re239/.travis/travis.sh ] && source /Users/re239/.travis/travis.sh
