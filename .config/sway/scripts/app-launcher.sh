#!/usr/bin/env bash

shopt -s nullglob

fzf_colors="fg:#cdd6f4,bg:#0b0712,hl:#7aa2f7,fg+:#cdd6f4,bg+:#24283b,hl+:#bd93f9,info:#e0af68,prompt:#7aa2f7,pointer:#f7768e,marker:#9ece6a,spinner:#7dcfff,border:#7aa2f7"

entries=$(awk -F= '
  FNR==1 { name=""; execl=""; nodisplay=""; hidden="" }
  /^Name=/ && !name { name=substr($0,6) }
  /^Exec=/ && !execl { execl=substr($0,6) }
  /^NoDisplay=/ { nodisplay=substr($0,11) }
  /^Hidden=/ { hidden=substr($0,8) }
  ENDFILE {
    if (name != "" && execl != "" && nodisplay != "true" && hidden != "true" && !(name in seen)) {
      seen[name] = 1
      print name "\t" execl
    }
  }
' ~/.local/share/applications/*.desktop /usr/local/share/applications/*.desktop /usr/share/applications/*.desktop 2>/dev/null)

choice=$(printf '%s\n' "$entries" | cut -f1 | sort |
  fzf --prompt=' ' --layout=reverse --border --color="$fzf_colors")

[ -z "$choice" ] && exit 0

exec_line=$(printf '%s\n' "$entries" | awk -F'\t' -v n="$choice" '$1 == n { print $2; exit }')
clean_exec=$(echo "$exec_line" | sed -E 's/%[fFuUick]//g')

setsid nohup bash -c "$clean_exec" </dev/null >>/tmp/app-launcher-debug.log 2>&1 &
disown
sleep 0.1
