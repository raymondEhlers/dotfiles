
# Created by `pipx` on 2021-08-09 22:36:47
export PATH="$PATH:${HOME}/.local/bin"

# pyenv
# Have to do this by hand, unfortunately...
export PYENV_ROOT="$HOME/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init --path)"
