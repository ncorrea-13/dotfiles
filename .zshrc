# envs
export PYENV_ROOT="$HOME/.pyenv"
export GOBIN="$HOME/.local/bin"
path=($HOME/.local/bin $PYENV_ROOT/bin $path)
export DOCKER_HOST=unix:///run/podman-service/podman.sock
export TAVILY_API_KEY=$(cat ~/.tavily_env)
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# inits
eval "$($HOME/.local/bin/mise activate zsh)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(zoxide init zsh)"
eval $(thefuck --alias)

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode reminder
export ZSH_THEME="powerlevel10k/powerlevel10k"

# plugins
plugins=(git zsh-autosuggestions  fast-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# alias
source ~/.alias

# p10k
source ~/.p10k.zsh

typeset -U path

# fastfetch
if [[ -n zellij ]]; then
	fastfetch
fi
