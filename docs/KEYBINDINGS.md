# Keybindings & Aliases Reference

_[Leer en español](KEYBINDINGS.es.md)_

This document covers every keyboard shortcut and shell alias defined in this dotfiles repository: **Sway** (window manager), **Wezterm** (terminal emulator), **Zellij** (terminal multiplexer), and the **Zsh** aliases/functions in `.alias`.

> **`$mod+shift+c`** shows a live, searchable list, generated straight from the Sway config (`.config/sway/scripts/keybinds-tui.sh`). It parses `variables` and every file in `keybindings/`, so it's never out of date.

---

## 1. Sway (Window Manager)

Sway config lives in `.config/sway/`, split into `variables` (key/app definitions) and the `keybindings/` directory (one file per topic).

### Modifier keys

| Variable | Key                        |
| -------- | -------------------------- |
| `$mod`   | `Mod4` (Super/Windows key) |
| `$alt`   | `Mod1` (Alt)               |

Vim-style directional keys are also mapped: `$left`=`h`, `$down`=`j`, `$up`=`k`, `$right`=`l`. Every directional binding below works with **both** the Vim keys and the physical arrow keys.

### General (`keybindings/basics`)

| Keybinding              | Action                                                           |
| ----------------------- | ---------------------------------------------------------------- |
| `$mod+Shift+q`          | Kill focused window                                              |
| `$mod+space`            | Open the app launcher (fzf-based TUI, `scripts/app-launcher.sh`) |
| `$mod+Shift+r`          | Reload Sway config                                               |
| `$mod+Shift+e`          | Exit Sway (end session)                                          |
| `$alt+Ctrl+l`           | Lock the screen (`rustlock-script`)                              |
| `$mod+slash`            | Open emoji picker (`smile`)                                      |
| `$mod+p`                | Open power menu TUI                                              |
| `$mod+tab`              | Run `sway-tab.sh` (window management)                            |
| `$mod+comma`            | Switch to previous workspace                                     |
| `$mod+period`           | Switch to next workspace                                         |
| `$mod+s` ; `Print`      | Screenshots                                                      |
| `XF86AudioRaiseVolume`  | Volume up 5%                                                     |
| `XF86AudioLowerVolume`  | Volume down 5%                                                   |
| `XF86AudioMute`         | Toggle mute (output)                                             |
| `XF86AudioMicMute`      | Toggle microphone mute                                           |
| `XF86MonBrightnessUp`   | Brightness +5%                                                   |
| `XF86MonBrightnessDown` | Brightness −5%                                                   |

The `floating_modifier` is also `$mod` - hold `$mod` and drag any window with the mouse to move it while floating.

### Applications (`keybindings/apps`)

| Keybinding    | Action                       |
| ------------- | ---------------------------- |
| `$mod+Return` | Launch terminal (Wezterm)    |
| `$mod+e`      | Launch file manager (Thunar) |
| `$mod+d`      | Launch Discord               |
| `$mod+n`      | Launch browser (LibreWolf)   |
| `$mod+o`      | Launch notes (Obsidian)      |
| `$mod+y`      | Launch YouTube (FreeTube)    |

Sway also auto-assigns known apps to fixed workspaces on launch, so things always open in the same place:

| Workspace | Apps                              |
| --------- | --------------------------------- |
| 1         | Mullvad Browser, LibreWolf, Brave |
| 2         | Wezterm                           |
| 3         | virt-manager, Obsidian, DBeaver   |
| 4         | Thunar                            |
| 5         | Zathura (PDF), ONLYOFFICE         |
| 7         | Discord                           |
| 8         | LocalSend                         |
| 9         | FreeTube, Hayase, Stremio, mpv    |
| 10        | Steam, Heroic Games Launcher      |

### Launchers - floating TUI utilities (`keybindings/launchers`)

These all open a small floating Wezterm popup (via `wezterm/tui-popup.lua`) running a specific TUI tool. Some are "kept alive" - instead of closing, they get pushed to the **scratchpad** via `scratchpad-toggle.sh` so re-pressing the shortcut just shows/hides the already-running instance instead of relaunching it.

| Keybinding                     | Action                                         | Kept alive? |
| ------------------------------ | ---------------------------------------------- | ----------- |
| `$mod+m`                       | Spotify (ncspot)                               | ✅          |
| `$mod+w`                       | Wi-Fi (`nmrs-tui`)                             |             |
| `$mod+b`                       | Bluetooth (`bluetui`)                          |             |
| `$mod+v`                       | Clipboard (`clipboard-tui.sh` with `cliphist`) |             |
| `$mod+Shift+b`                 | Bitwarden                                      | ✅          |
| `$mod+u`                       | Topgrade                                       | ✅          |
| `$mod+t`                       | Btop                                           |             |
| `$mod+c`                       | iKahl                                          |             |
| `$mod+Shift+y`                 | YouTube (`ytsurf`)                             |             |
| `$mod+Shift+n`                 | Nchat (Telegram/Signal/WhatsApp)               |             |
| `$mod+Shift+d`                 | Discord (Concord)                              | ✅          |
| `$mod+Shift+o`                 | Ekphos                                         |             |
| `$mod+Shift+t`                 | Localsend (LocalSend)                          |             |
| `$mod+Shift+f`                 | Auto-cpufreq                                   |             |
| `$mod+c`                       | Keybindings                                    |             |
| `XF86Display` / `$mod+Shift+p` | Monitor control                                |             |

### Movement & layout (`keybindings/movement`)

| Keybinding                                   | Action                                 |
| -------------------------------------------- | -------------------------------------- |
| `$mod+h/j/k/l` or arrow keys                 | Move focus left/down/up/right          |
| `$mod+Shift+h/j/k/l` or `$mod+Shift+`+arrows | Move focused window left/down/up/right |
| `$mod+alt+s`                                 | Set layout to stacking                 |
| `$mod+alt+w`                                 | Set layout to tabbed                   |
| `$mod+f`                                     | Toggle fullscreen                      |
| `$mod+Shift+space`                           | Toggle floating for focused window     |
| `$mod+a`                                     | Focus parent container                 |

### Workspaces (`keybindings/workspaces`)

| Keybinding                    | Action                                      |
| ----------------------------- | ------------------------------------------- |
| `$mod+1`…`$mod+0`             | Switch to workspace 1–10                    |
| `$mod+Shift+1`…`$mod+Shift+0` | Move focused window to workspace 1–10       |
| `$mod+Shift+m`                | Move current workspace to the other monitor |

### Resize mode (`keybindings/resizing`)

| Keybinding                      | Action            |
| ------------------------------- | ----------------- |
| `$mod+r`                        | Enter resize mode |
| `h`/`←`                         | Shrink width      |
| `l`/`→`                         | Grow width        |
| `k`/`↑`                         | Shrink height     |
| `j`/`↓`                         | Grow height       |
| `Return`, `Escape`, or `$mod+r` | Exit resize mode  |

### Scratchpad (`keybindings/scratchpad`)

| Keybinding          | Action                                |
| ------------------- | ------------------------------------- |
| `$mod+Shift+Return` | Send focused window to the scratchpad |
| `$mod+minus`        | Show/cycle scratchpad windows         |

---

## 2. Wezterm (Terminal Emulator)

The tab shortcuts only work via keyboard while Wezterm is open.

| Keybinding         | Action                              |
| ------------------ | ----------------------------------- |
| `Ctrl+Shift+n`     | Spawn a new tab                     |
| `Ctrl+Shift+x`     | Close current tab (no confirmation) |
| `Ctrl+Shift+h`     | Activate previous tab               |
| `Ctrl+Shift+l`     | Activate next tab                   |
| `Ctrl+Shift+1`…`4` | Jump to tab 1–4                     |

There is also `.config/wezterm/tui-popup.lua`, a stripped-down profile used exclusively to launch the launchers.

---

## 3. Zellij (Terminal Multiplexer)

Zellij starts in **`locked` mode**, where keys pass straight through to the shell. Press **`Ctrl+g`** to unlock into `normal` mode and access the shortcuts below; press `Ctrl+g` again to relock.

### Mode switches (available once unlocked)

| Key      | Enters mode  |
| -------- | ------------ |
| `p`      | Pane mode    |
| `t`      | Tab mode     |
| `r`      | Resize mode  |
| `s`      | Scroll mode  |
| `o`      | Session mode |
| `m`      | Move mode    |
| `Ctrl+q` | Quit Zellij  |

### Global (work in `normal` and `locked`, no mode switch needed)

| Key                         | Action                                     |
| --------------------------- | ------------------------------------------ |
| `Alt+h/j/k/l` or `Alt+←↓↑→` | Move focus (crosses tabs at edges)         |
| `Alt+n`                     | New pane                                   |
| `Alt+f`                     | Toggle floating panes                      |
| `Alt+ +` / `Alt+ -`         | Increase/decrease pane size                |
| `Alt+[` / `Alt+]`           | Cycle previous/next swap layout            |
| `Alt+i` / `Alt+o`           | Move tab left/right                        |
| `Alt+y`                     | Open the "zellij-forgot" cheatsheet plugin |

### Pane mode (`p`)

| Key                 | Action                             |
| ------------------- | ---------------------------------- |
| `h/j/k/l` or arrows | Focus pane left/down/up/right      |
| `n`                 | New pane                           |
| `d`                 | New pane below                     |
| `r`                 | New pane to the right              |
| `x`                 | Close focused pane                 |
| `f`                 | Toggle fullscreen for focused pane |
| `e`                 | Toggle pane embed/floating         |
| `w`                 | Toggle all floating panes          |
| `c`                 | Rename pane                        |
| `z`                 | Toggle pane frames                 |

### Tab mode (`t`)

| Key                 | Action                                        |
| ------------------- | --------------------------------------------- |
| `h/j/k/l` or arrows | Previous/next tab                             |
| `1`–`9`             | Jump to tab N                                 |
| `n`                 | New tab                                       |
| `x`                 | Close tab                                     |
| `r`                 | Rename tab                                    |
| `s`                 | Toggle synchronized input across panes in tab |
| `b`                 | Break pane out into a new tab                 |
| `[` / `]`           | Break pane left/right                         |

### Resize mode (`r`)

| Key                 | Action                   |
| ------------------- | ------------------------ |
| `h/j/k/l` or arrows | Grow in that direction   |
| `H/J/K/L` (shift)   | Shrink in that direction |
| `+` / `-` / `=`     | Increase/decrease        |

### Move mode (`m`)

| Key                 | Action                              |
| ------------------- | ----------------------------------- |
| `h/j/k/l` or arrows | Move focused pane in that direction |
| `n`                 | Move to next pane                   |
| `p`                 | Move to previous pane               |

### Scroll mode (`s`)

| Key               | Action                              |
| ----------------- | ----------------------------------- |
| `j`/`k`           | Scroll down/up one line             |
| `h`/`l`           | Page up/down                        |
| `Ctrl+f`/`Ctrl+b` | Page down/up                        |
| `u`/`d`           | Half-page up/down                   |
| `f`               | Enter search                        |
| `e`               | Edit scrollback in `$EDITOR` (nvim) |
| `Ctrl+c`          | Scroll to bottom & relock           |

### Session mode (`o`)

| Key | Action                |
| --- | --------------------- |
| `w` | Open session manager  |
| `p` | Open plugin manager   |
| `c` | Open configuration UI |
| `d` | Detach session        |

---

## 4. Neovim

Neovim is a [LazyVim](https://www.lazyvim.org/) distribution, so it inherits all of LazyVim's default `<leader>` keymaps (the leader is `space`). On top of the plugins LazyVim already manages, this config adds:

| Keybinding     | Action                                        |
| -------------- | --------------------------------------------- |
| `<leader>r`    | LSP rename (inline, via `live_rename.nvim`)   |
| `<leader>R`    | LSP rename with an extra character of padding |
| `<leader><F5>` | Toggle Undotree                               |

For the full default keymap set, see the [LazyVim keymaps documentation](https://www.lazyvim.org/keymaps).

---

## 5. Shell Aliases & Functions (`.alias`)

Sourced from `.zshrc`. Shell is Zsh with `oh-my-zsh` + `powerlevel10k`.

### Functions

| Name       | Purpose                                                                                                      |
| ---------- | ------------------------------------------------------------------------------------------------------------ |
| `rc <cmd>` | Run `<cmd>` as root (via `doas`) with a clean, predictable `PATH` - this system's `sudo`-equivalent wrapper. |
| `fuck`     | Lazily loads and runs [`thefuck`](https://github.com/nvbn/thefuck), only on the first invocation.            |

### Core utility replacements

| Alias | Replaces | With                                                  |
| ----- | -------- | ----------------------------------------------------- |
| `ls`  | `ls`     | [`lsd`](https://github.com/lsd-rs/lsd)                |
| `cat` | `cat`    | [`batcat`](https://github.com/sharkdp/bat)            |
| `cd`  | `cd`     | [`zoxide`](https://github.com/ajeetdsouza/zoxide)     |
| `up`  | -        | [`topgrade`](https://github.com/topgrade-rs/topgrade) |

### Messaging (nchat)

| Alias           | Purpose                                                                  |
| --------------- | ------------------------------------------------------------------------ |
| `telegram`      | Open [nchat](https://github.com/d99kris/nchat) with the Telegram profile |
| `signal`        | Open nchat with the Signal profile                                       |
| `whatsapp`      | Open nchat with the personal WhatsApp profile                            |
| `whatsapp-work` | Open nchat with the work WhatsApp profile                                |

### Misc utilities

| Alias/Function | Purpose                                                                               |
| -------------- | ------------------------------------------------------------------------------------- |
| `concord`      | Discord TUI client, launched with the correct ALSA plugin dir for audio               |
| `pomodoro`     | 45-minute work / 15-minute break Pomodoro timer, 4 cycles (`tomatoshell`)             |
| `health`       | Prints CPU frequency, package temperature, and battery status/cycle count in one shot |
| `bw-auth`      | Unlocks Bitwarden CLI and exports the session key (`BW_SESSION`)                      |

### OpenRC service management

This system runs OpenRC (systemd-free), so services are managed through `rc` + `rc-service`/`rc-update`/`rc-status`:

| Alias                                | Purpose                                                              |
| ------------------------------------ | -------------------------------------------------------------------- |
| `rcs`                                | `rc-status` - show service status                                    |
| `rcu`                                | `rc-update` - manage service enablement                              |
| `rcsv`                               | `rc-service` - start/stop/restart a service                          |
| `rclist`                             | List all services and their runlevels, verbose                       |
| `rccrash`                            | List crashed services                                                |
| `cups-on` / `cups-off` / `cups-stat` | Start/stop/check the printing stack (`cups`, `cups-browsed`)         |
| `vm-on` / `vm-off`                   | Start/stop the libvirt virtualization stack (`libvirtd`, `virtlogd`) |
| `pod-on` / `pod-off`                 | Start/stop the Podman socket service                                 |

### Arch VM (BlackArch)

A libvirt VM used for security tooling:

| Alias         | Purpose                                                                                   |
| ------------- | ----------------------------------------------------------------------------------------- |
| `arch-on`     | Start the `archlinux` VM                                                                  |
| `arch-off`    | Shut down the `archlinux` VM                                                              |
| `arch-ssh`    | SSH into the VM (host alias `arch-vm`)                                                    |
| `arch-status` | List all libvirt domains and their state                                                  |
| `arch-work`   | Start the VM, poll until it gets a DHCP lease on `192.168.x.x`, then SSH in automatically |

---

## 6. Waybar (Status Bar)

Mirrors a few of the Sway launcher shortcuts as mouse clicks on the bar, so the same tools are reachable without the keyboard:

| Module     | Click action                           |
| ---------- | -------------------------------------- |
| Logo       | Opens `btop`                           |
| Network    | Opens the Wi-Fi TUI (`nmrs-tui`)       |
| Bluetooth  | Opens the Bluetooth TUI (`bluetui`)    |
| Power      | Opens the power menu TUI               |
| Workspaces | Click a workspace icon to switch to it |
