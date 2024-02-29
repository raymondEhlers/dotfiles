
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

# Setup shell completions. As far as I understand in April 2022, I think this be fairly early on
# Add additional zsh functions (as of April 2022, introduced for poetry)
fpath+=~/.zfunc
# Add git zsh completion. Apparently it's rather different than bash...
autoload -U compinit && compinit
zmodload -i zsh/complist
# For bash completions support, I think (?)
autoload -U bashcompinit && bashcompinit

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
    # We want a python -> python3 symlink
    # My initial solution to this only worked by coincidence because the python3 version aligned...
    # Need to make symlinks in the bin directory of the python install (usually via homebrew)
fi

# Language specific setup
# Python
# Pyenv (must go before retrieving the user-base path)
# Moved PYENV_ROOT and PATH to .zprofile, since this is the new convention
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init -)"
fi
# Add bin for pip packages installed with `--user`
pythonUserPrefix="$(python3 -m site --user-base)"
addToPath "${pythonUserPrefix}/bin"
# Ensure we're in a virtualenv
export PIP_REQUIRE_VIRTUALENV=true
# Go
# It's fairly likely that go will be installed in /usr/local/go, so we assume that here.
addToPath "/usr/local/go/bin"

# Options
# General
export EDITOR="nvim"
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

# Determine the alibuild architecture. This will only work on architectures where
# I've tested it, but that's probably good enough
alibuildArchitechture()
{
    arch=""
    for p in ${ALIBUILD_WORK_DIR}/*; do
        # We want just the dir name, not the whole path
        d=$(basename ${p})
        if [[ "${d}" ==  *"ubuntu"* || "${d}" ==  *"osx"* ]]; then
            # Once we've found the architecture, we can continue.
            # There will be only one architecture-like directory.
            arch="${d}"
            break
        fi
    done
    echo "$arch"
}
# If we're on Debian, we always need to set the architecture. So we redefine the aliBuild and alienv
# commands when appropriate. For now, we'll grab the architecture name from the AliBuild dir so we
# don't have to map names to Ubuntu versions.
if command -v lsb_release &> /dev/null; then
    if [[ "Debian" == "$(lsb_release -si)" ]]; then
        additionalOptions=""
        arch=$(alibuildArchitechture)
        if [[ ! -z "${arch}" ]]; then
            additionalOptions="--architecture ${arch}"
        fi
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
    # Remove the Python-modules virtualenv from everything. The packages are old and pinned, so
    # better to just remove them. In the unexpected case where we actually need one of these
    # dependencies, I can install it into my current virtualenv.
    # NOTE: We can't just unset the PYTHONPATH because we need it for ROOT, xjalienfs, etc.
    # NOTE: We also need to remove from the PATH, LD_LIBRARY_PATH
    # sed based on here: https://superuser.com/a/1117805
    arch=$(alibuildArchitechture)
    export PATH=$(sed "s,:$ALIBUILD_WORK_DIR/$arch/Python-modules/[^:]\+\(:\|$\),,g" <<< "$PATH")
    export LD_LIBRARY_PATH=$(sed "s,:$ALIBUILD_WORK_DIR/$arch/Python-modules/[^:]\+\(:\|$\),,g" <<< "$LD_LIBRARY_PATH")
    export PYTHONPATH=$(sed "s,:$ALIBUILD_WORK_DIR/$arch/Python-modules/[^:]\+\(:\|$\),,g" <<< "$PYTHONPATH")

    # Work around missing python library (due to AliBuild bug?? Unclear). It seems likely that
    # it's due to AliBuild ignoring the rpath specified in python on Linux (but it follows it
    # on macOS). In any case, we can resolve it by adding explicitly to the LD_LIBRARY_PATH.
    # NOTE: This requires the AliPhysics ctests to be disabled because it won't load the modified
    #       LD_LIBRARY_PATH for the tests, which means it won't succeed on the first AliBuild build.
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

# pipx
# I would put this earlier, but it appears to cause some issues. I'm probably missing some dependence,
# but it seems to work fine here, so good enough...
eval "$(register-python-argcomplete pipx)"
# Needed for executables
addToPath "${HOME}/.local/bin"

# GitHub Copilot for nvim:
# Note that I need node 18 explicitly
addToPath "/opt/homebrew/opt/node@18/bin"

# added by travis gem
[ -f /Users/re239/.travis/travis.sh ] && source /Users/re239/.travis/travis.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/mambaforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/mambaforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/mambaforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/mambaforge/base/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/opt/homebrew/Caskroom/mambaforge/base/etc/profile.d/mamba.sh" ]; then
    . "/opt/homebrew/Caskroom/mambaforge/base/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

