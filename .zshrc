# envs
export GOBIN="$HOME/.local/bin"
path=($HOME/.local/bin $HOME/.cargo/bin  /home/linuxbrew/.linuxbrew/bin $path)
export DOCKER_HOST=unix:///run/podman-service/podman.sock
export TAVILY_API_KEY=$(cat ~/.tavily_env)

# inits
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
fastfetch
