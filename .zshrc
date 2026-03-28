# fastfetch
if [[ -n zellij ]]; then
	fastfetch
fi

# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# path
export PATH=$HOME/.local/bin:$PATH
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
export GOBIN="$HOME/.local/bin"
export DOCKER_HOST=unix:///run/user/1000/podman/podman.sock
export DOCKER_HOST="unix://$HOME/.podman.sock"
if [ ! -S "$HOME/.podman.sock" ]; then
    rm -f "$HOME/.podman.sock"
    (podman system service --time=0 "$DOCKER_HOST" >/dev/null 2>&1 &)
fi

# mise
if [[ -f "$HOME/.local/bin/mise" ]]; then
  eval "$($HOME/.local/bin/mise activate zsh)"
fi

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode reminder

# plugins
plugins=(git zsh-autosuggestions  fast-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# inits
eval "$(zoxide init zsh)"
eval $(thefuck --alias)

# tavily for avante.nvim
export TAVILY_API_KEY=$(cat ~/.tavily_env)

# alias
alias ls='lsd'
alias cat='batcat'
alias cd='z'
alias up='topgrade'
alias ncspot='flatpak run io.github.hrkfdn.ncspot'
alias pomodoro='tomatoshell -f -t 45.00 -d 15.00 -n 4'
alias health='echo "\e[1;34m--- CPU Status ---\e[0m" && grep MHz /proc/cpuinfo | head -n 4 && echo "\e[1;33m--- Temp ---\e[0m" && sensors | grep "Package id 0" && echo "\e[1;32m--- Battery ---\e[0m" && sudo tlp-stat -b | grep -E "Percentage|status|cycle_count"'

# p10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
