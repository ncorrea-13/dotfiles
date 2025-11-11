# Execute fastfetch every time the terminal is opened
if [[ -n zellij ]]; then
	fastfetch
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# This is to make the bip sound turn off in case i3wm does not do that
xset b off

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set the powerlevel10k themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Export the tavily api key for avante.nvim
export TAVILY_API_KEY=$(cat ~/.tavily_env)

zstyle ':omz:update' mode reminder  # just remind me to update when it's time

plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias ls='lsd'
alias cat='batcat'
alias cd='z'
alias spotify='ncspot'
alias telegram='nchat -d ~/.config/nchat-telegram'
alias whatsapp='nchat -d ~/.config/nchat-whatsapp'
alias pomodoro='tomatoshell -f -t 45.00 -d 15.00 -n 4'

eval "$(zoxide init zsh)"
eval $(thefuck --alias)
export DOCKER_HOST=unix:///run/user/1000/podman/podman.sock # This allows to use podman with lazydocker
export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
