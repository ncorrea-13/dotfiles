#!/usr/bin/env bash

fzf_colors="fg:#cdd6f4,bg:#0b0712,hl:#7aa2f7,fg+:#cdd6f4,bg+:#24283b,hl+:#bd93f9,info:#e0af68,prompt:#7aa2f7,pointer:#f7768e,marker:#9ece6a,spinner:#7dcfff,border:#7aa2f7"

selected=$(cliphist list | fzf --prompt="Clipboard > " --layout=reverse --border --color="$fzf_colors")
[ -z "$selected" ] && exit 0

echo "$selected" | cliphist decode | wl-copy
