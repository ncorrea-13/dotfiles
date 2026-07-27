# Scripts Reference

_[Leer en español](SCRIPTS.es.md)_

This repo ships two kinds of shell scripts:

- **`.config/sway/scripts/`** - interactive tools wired to Sway/Waybar keybindings. Most are `fzf` pickers, several are launched inside a small floating Wezterm popup (see [KEYBINDINGS.md](KEYBINDINGS.md) for the exact shortcuts and popup profile).
- **`scripts/`** - standalone installation/maintenance scripts and the lock screen wrappers. These are expected to live on `$PATH` (e.g. symlinked into `~/.local/bin`) under their own name, since `variables` and other scripts
  call them by bare name (`rustlock-script`, etc.).

---

## `.config/sway/scripts/`

### `app-launcher.sh`

Custom application launcher. Parses every `.desktop` file under the user/system application directories, keeps the first `Name=`/`Exec=` pair per file, and offers the list through `fzf`. The chosen `Exec=` line has its desktop field codes (`%f %F %u %U %i %c %k`) stripped and is launched detached so it survives the launcher process exiting.
**Depends on:** `fzf`, `awk`, `bash`.

### `clipboard-tui.sh`

`fzf` front-end for clipboard history. Lists entries from `cliphist list`, lets you pick one, and copies it back to the Wayland clipboard with `wl-copy`.
**Depends on:** `cliphist`, `fzf`, `wl-copy`.

### `keybinds-tui.sh`

Generates the live keybindings list. Parses `.config/sway/variables` for `set $var` definitions and every file referenced from `keybindings/` in the main Sway config, substitutes the variables, humanizes modifier names (`Mod4`→`Super`, `Mod1`→`Alt`), and renders a colorized, sectioned list through `less`. Reads the _live_ config instead of a static copy.
**Depends on:** `awk`, `grep`, `less`.

### `lock.sh`

Idle & sleep daemon, started at Sway startup. Runs `swayidle` with four triggers: lock the screen and wipe the cached Bitwarden session after 10 minutes idle, turn outputs off (`dpms off`) 10 seconds after that, turn them back on on resume, and lock immediately before suspending. The actual lock screen is delegated to [`rustlock-script`](#rustlock-script--swaylock-script--i3lock-script).
**Depends on:** `swayidle`, `bw` (Bitwarden CLI), `rustlock-script`.

### `nchat-picker.sh`

Account picker for `nchat`. Lets you pick a messaging account (Telegram, Signal, WhatsApp personal/work) and opens `nchat` pointed at that account's config dir inside a floating Wezterm popup. If a `nchat` window is already open on the _same_ account it's just recalled from the scratchpad; if it's open on a _different_ account, the old instance is killed first. Remembers the last-selected account in `~/.cache/nchat_account`.
**Depends on:** `fzf`, `swaymsg`, `jq`, `wezterm`.

### `powermenu.sh`

`fzf` menu for shutdown / reboot / hibernate / suspend / logout / lock; every destructive action is gated behind a Yes/No confirmation prompt. Suspend additionally pauses `mpc` and mutes ALSA before calling suspend. All actions go through `elogind`.
**Depends on:** `fzf`, `elogind`, optionally `mpc`/`amixer`.

### `scratchpad-toggle.sh`

Helper behind every "kept alive" launcher. Given an `app_id` and a command, it checks whether a window with that `app_id` already exists in the Sway tree: if so it just shows it from the scratchpad, otherwise it `exec`s the command to launch it fresh. This is what makes `$mod+m`, `$mod+Shift+b`, `$mod+u` and `$mod+Shift+d` toggle a single instance instead of spawning duplicates.
**Depends on:** `swaymsg`, `jq`.

### `screenshot-tui.sh`

Screenshot & screen-recording tool. `fzf` menu to pick area/window/fullscreen capture, then copy-to-clipboard or save-to-file (`~/Pictures/Screenshots`); or start/stop a screen recording (`~/Videos/Screencasts`) via `wf-recorder`. Pressing the shortcut again while recording stops it. Sends a desktop notification on completion.
**Depends on:** `fzf`, `grim`, `slurp`, `wf-recorder`, `notify-send`, `wl-copy`.

### `screen-tui.sh`

Monitor layout switcher. Detects a second connected output besides the built-in `eDP-1` panel and lets you fuzzy-pick Notebook-only / Monitor-only / Dual-screen, applying resolution and position via `swaymsg output`.
**Depends on:** `swaymsg`, `jq`, `fzf`, `notify-send`.

> The laptop output name (`eDP-1`) and resolutions are hardcoded.

### `sway-tab.sh`

Window switcher. Walks the Sway tree into a flat list of `[workspace] app_id` for every window, and jumps to the workspace of whichever one you pick via `fzf`.
**Depends on:** `swaymsg`, `jq`, `fzf`.

---

## `scripts/` (installation & maintenance)

### `bw-tui`

Bitwarden CLI password picker. It was migrated to it's own project ([bw-tui](https://github.com/ncorrea-13/bw-tui))

### `bw-update`

One-shot updater for the Bitwarden CLI binary itself: fetches the latest `cli-v*` tag from the `bitwarden/clients` GitHub releases API, downloads the matching Linux zip, and installs `bw` into `~/.local/bin`.
**Depends on:** `curl`, `unzip`.

### `discordDownloader`

Installer/updater for Discord on Debian-based systems, requires root: downloads the official `.deb`, installs it via `dpkg`/`apt`, launches Discord once as the invoking user with that user's Wayland/X11 environment recovered from their running session, then installs BetterDiscord.
**Depends on:** `wget`, `dpkg`/`apt`, `doas`/`sudo`, `bdcli` (BetterDiscord
CLI, expected at `~/.local/bin/bdcli`).

### `dotfiles.sh`

Reverse-sync helper: copies the _live_ configs from `~/.config` (`sway`, `waybar`, `dunst`, `btop`, `fastfetch`, `wezterm`, `zellij`, `cava`, `nvim`, `posting`, `mpv`) plus `topgrade.toml` back into this repo (`~/Projects/things/dotfiles`). Meant to be run with `~/.config` as the working directory, as a quick way to pull current machine state back into version control before committing.
**Depends on:** coreutils (`cp`) only.

### `rustlock-script`

Lock-screen wrapper around `rustlock`, pre-configured with this setup's color scheme. This is the one currently wired up.
**Depends on:** `rustlock`.

---

## Legacy (unmaintained, X11 only)

Kept for reference only, same as in [PERSONALPROGRAMS.md](PERSONALPROGRAMS.md#legacy-unmaintained-x11-only) - not wired to anything in the current Wayland/Sway setup.

### `swaylock-script`

Lock-screen wrapper around `swaylock`, with the same color scheme as `rustlock-script`.
**Depends on:** `swaylock-effects`.

### `i3lock-script`

Lock-screen wrapper around `i3lock`.
**Depends on:** `i3lock-fancy`.
