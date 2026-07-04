# envs
export GOBIN="$HOME/.local/bin"
export DOCKER_HOST=unix:///run/podman-service/podman.sock
export TAVILY_API_KEY=$(cat ~/.tavily_env)

# inits
eval "$(mise activate zsh --shims)"
eval "$(zoxide init zsh)"

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode reminder
export ZSH_THEME="powerlevel10k/powerlevel10k"

# plugins
plugins=(git zsh-autosuggestions  fast-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# p10k
source ~/.p10k.zsh

# fastfetch
if [[ -z "$FASTFETCH_SHOWN" ]]; then
    fastfetch
    export FASTFETCH_SHOWN=1
fi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac

# alias
source ~/.alias
