#!/usr/bin/env bash

set -euo pipefail

sway_dir="$HOME/.config/sway"
config_file="$sway_dir/config"
vars_file="$sway_dir/variables"

mapfile -t kb_files < <(grep -oE 'keybindings/[A-Za-z_-]+' "$config_file" | sed "s#^#$sway_dir/#")

awk '
BEGIN {
  reset  = "\033[0m"
  title  = "\033[1;38;2;122;162;247m"
  sect   = "\033[1;38;2;125;207;255m"
  rule   = "\033[2;38;2;122;162;247m"
  keyc   = "\033[38;2;189;147;249m"
  descc  = "\033[38;2;205;214;244m"
  last_section = ""
  printf "\n  %sSway Keybindings%s\n", title, reset
  printf "  %s══════════════════════════════════════════════════%s\n", rule, reset
}
FNR==NR {
  if ($0 ~ /^set +\$/) {
    line = $0
    sub(/^set +\$/, "", line)
    name = line
    sub(/ .*/, "", name)
    value = line
    sub(/^[^ ]+ +/, "", value)
    vars[name] = value
  }
  next
}
function subst(s,    result, pos, name) {
  result = ""
  while ((pos = match(s, /\$[A-Za-z_][A-Za-z0-9_]*/)) > 0) {
    name = substr(s, pos + 1, RLENGTH - 1)
    result = result substr(s, 1, pos - 1)
    if (name in vars) result = result vars[name]
    else result = result "$" name
    s = substr(s, pos + RLENGTH)
  }
  return result s
}
function rep(n,    r, i) {
  r = ""
  for (i = 0; i < n; i++) r = r "─"
  return r
}
function basename(p,    parts, n) {
  n = split(p, parts, "/")
  return parts[n]
}
function friendly(cmd,    tok, pos) {
  if (match(cmd, /--class +[^ ]+/)) {
    tok = substr(cmd, RSTART, RLENGTH)
    sub(/--class +/, "", tok)
    gsub(/[-_]/, " ", tok)
    tok = toupper(substr(tok,1,1)) substr(tok,2)
    return tok
  }
  pos = index(cmd, " ")
  tok = (pos > 0) ? substr(cmd, 1, pos - 1) : cmd
  return basename(tok)
}
FNR==1 {
  section = FILENAME
  sub(/.*\//, "", section)
  section = toupper(substr(section,1,1)) substr(section,2)
  pending = ""
  dash = 0
  want_title = 0
  in_resize = 0
}
/^# *-+ *$/ {
  dash++
  if (dash == 1) want_title = 1
  else if (dash == 2) dash = 0
  next
}
want_title {
  s = $0
  sub(/^# */, "", s)
  sub(/ *\(.*/, "", s)
  section = s
  want_title = 0
  next
}
/^ *mode *"resize" *\{/ {
  in_resize = 1
  saved_section = section
  section = "Resize mode"
  next
}
in_resize && /^\}/ {
  in_resize = 0
  section = saved_section
  next
}
/^ *#/ {
  s = $0
  sub(/^ *# */, "", s)
  if (s !~ /^bindsym /) pending = s
  next
}
/^ *$/ {
  pending = ""
  next
}
/^ *bindsym +/ {
  rest = $0
  sub(/^ *bindsym +/, "", rest)
  split_pos = index(rest, " ")
  key = substr(rest, 1, split_pos - 1)
  action = substr(rest, split_pos + 1)

  key_disp = subst(key)
  gsub(/Mod4/, "Super", key_disp)
  gsub(/Mod1/, "Alt", key_disp)
  gsub(/[Ss]hift/, "Shift", key_disp)
  gsub(/[Cc]trl/, "Ctrl", key_disp)

  is_exec = (action ~ /^exec +/)
  action_disp = subst(action)
  sub(/^exec +/, "", action_disp)

  desc = pending
  if (desc == "") {
    if (is_exec) desc = friendly(action_disp)
    else desc = action_disp
  }

  if (section != last_section) {
    printf "\n  %s%s%s\n", sect, section, reset
    printf "  %s%s%s\n", rule, rep(length(section)), reset
    last_section = section
  }
  printf "    %s%-22s%s %s%s%s\n", keyc, key_disp, reset, descc, desc, reset
  next
}
{ pending = "" }
END {
  printf "\n"
}
' "$vars_file" "${kb_files[@]}" | less -R -P "Sway Keybindings — / buscar, q salir"
