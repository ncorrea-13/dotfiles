# fastfetch
if [[ -n zellij ]]; then
	fastfetch
fi

# path
export PATH=$HOME/.local/bin:$PATH
source "$HOME/.cargo/env"
export GOBIN="$HOME/.local/bin"
export DOCKER_HOST=unix:///run/podman-service/podman.sock
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# mise
eval "$($HOME/.local/bin/mise activate zsh)"

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode reminder
export ZSH_THEME="powerlevel10k/powerlevel10k"

# plugins
plugins=(git zsh-autosuggestions  fast-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# inits
eval "$(zoxide init zsh)"
eval $(thefuck --alias)
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# tavily for avante.nvim
export TAVILY_API_KEY=$(cat ~/.tavily_env)

# alias
source ~/.alias

# p10k
source ~/.p10k.zsh
