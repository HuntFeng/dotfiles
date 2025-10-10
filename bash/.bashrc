#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -lh'

# prompt
PS1='[\u@\h \W]\$ '
eval "$(starship init bash)"

# cargo
. "$HOME/.cargo/env"

# n for node and nvm version manager
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

