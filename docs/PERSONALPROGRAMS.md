# Personal Programs

_[Leer en español](PERSONALPROGRAMS.es.md)_

A list of every program these dotfiles reference, for setting them up on a fresh installation. Split in two:

- **Essential** - the desktop session itself (window manager, bar, lock screen, clipboard, shell, etc.) doesn't work without these.
- **Personal** - specific application choices (browsers, chat clients, entertainment, dev tools...). Swap any of these for your own favorites and the rest of the setup keeps working.

---

## Essential

### Wayland session & window manager

- [SwayFX](https://github.com/WillPower3309/swayfx) - Sway fork with blur, rounded corners and shadows (used for `corner_radius`, `blur`, `shadows` in `variables`)
- [Waybar](https://github.com/Alexays/Waybar) - status bar
- [autotiling](https://github.com/nwg-piotr/autotiling) - automatic tiling layout for Sway
- [sway-fader](https://github.com/mgnsk/sway-fader) - fade-in effect on new/focused windows
- [swaybg](https://github.com/swaywm/swaybg) - wallpaper
- [swayidle](https://github.com/swaywm/swayidle) - idle handling (`lock.sh`)
- [Dunst](https://github.com/dunst-project/dunst) - notification daemon
- [mate-polkit](https://github.com/mate-desktop/mate-polkit) - polkit authentication agent (fingerprint/password prompts)
- [greetd](https://git.sr.ht/~kennylevinsen/greetd/) - login manager daemon
- [rustlock](https://github.com/JorySeverijnse/rustlock) - the lock screen actually in use

### Clipboard & screenshots

- [wl-clipboard](https://github.com/bugaevc/wl-clipboard) (`wl-copy`/`wl-paste`)
- [cliphist](https://github.com/sentriz/cliphist) - clipboard history
- [grim](https://sr.ht/~emersion/grim/) + [slurp](https://github.com/emersion/slurp) - screenshots
- [wf-recorder](https://github.com/ammen99/wf-recorder) - screen recording

### Audio, brightness & power

- [WirePlumber](https://gitlab.freedesktop.org/pipewire/wireplumber) (`wpctl`) + [PipeWire](https://pipewire.org) (`pactl`)
- [WireMix](https://github.com/tsowell/wiremix)
- [brightnessctl](https://github.com/Hummer12007/brightnessctl)
- [auto-cpufreq](https://github.com/AdnanHodzic/auto-cpufreq)

### Shell & terminal

- [Wezterm](https://wezterm.org) - terminal emulator
- [Zsh](https://www.zsh.org) + [Oh My Zsh](https://ohmyz.sh) + [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) + [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting)
- [zoxide](https://github.com/ajeetdsouza/zoxide) (`cd` → `z`)
- [lsd](https://github.com/lsd-rs/lsd) (`ls`)
- [bat](https://github.com/sharkdp/bat) (`cat`/`batcat`)
- [doas / OpenDoas](https://github.com/Duncaen/OpenDoas) - `sudo` replacement, used everywhere via the `rc` alias

### Pickers & launcher

- [fzf](https://github.com/junegunn/fzf) - powers almost every TUI picker in `.config/sway/scripts/`
- [jq](https://jqlang.github.io/jq/) - JSON parsing for `swaymsg` output in several scripts

### Core system & files

- [OpenRC](https://github.com/OpenRC/openrc) - service management (used through the `.alias` wrappers, `rc rc-status` etc.)
- [Syncthing](https://syncthing.net) - file sync, started at Sway startup
- [Thunar](https://docs.xfce.org/xfce/thunar/start) - file manager (`$mod+e`)

### Fonts & cursor

- [Nerd Fonts](https://www.nerdfonts.com) - JetBrainsMono Nerd Font (Sway/Waybar) and HackNerdFont (Wezterm); icons break everywhere without these
- [Oreo Cursors](https://github.com/varlesh/oreo-cursors) - cursor theme (`$cursor_theme oreo`)

---

## Personal

### Browsers

- [Mullvad Browser](https://mullvad.net/en/browser)
- [LibreWolf](https://librewolf.net)

### Messaging & social

- [Nchat](https://github.com/d99kris/nchat) - Telegram/Signal/WhatsApp TUI client
- Discord, [Concord](https://github.com/chojs23/concord) (Discord TUI client), [bdcli](https://github.com/BetterDiscord/cli) (BetterDiscord installer, run from `discordDownloader`)
- [Jocalsend](https://git.kittencollective.com/nebkor/joecalsend) + [LocalSend](https://github.com/localsend/localsend)

### Entertainment

- [FreeTube](https://freetubeapp.io)
- [Hayase](https://github.com/hayase-app/ui) (formerly Miru)
- [Stremio](https://www.stremio.com)
- [ncspot](https://github.com/hrkfdn/ncspot) - Spotify TUI client
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) + [ytsurf](https://github.com/Stan-breaks/ytsurf) + [mpv](https://mpv.io)

### Productivity

- [Obsidian](https://obsidian.md) + [Ekphos](https://github.com/hanebox/ekphos) (terminal, Obsidian-inspired) + [Basalt](https://github.com/erikjuhani/basalt) (TUI, Obsidian-inspired)
- [Bitwarden CLI](https://bitwarden.com/help/cli/) + [bw-tui](https://github.com/ncorrea-13/bw-tui)
- [ONLYOFFICE](https://www.onlyoffice.com)
- [Zathura](https://pwmt.org/projects/zathura/) - PDF viewer
- [tomatoshell](https://github.com/LytixDev/tomatoshell) - Pomodoro timer
- [tennis](https://github.com/gurgeous/tennis)

### Development

- [Neovim](https://neovim.io) ([LazyVim](https://www.lazyvim.org))
- [Vim](https://www.vim.org) - fallback editor
- [Zellij](https://zellij.dev) - terminal multiplexer
- [lazygit](https://github.com/jesseduffield/lazygit), [lazydocker](https://github.com/jesseduffield/lazydocker), [lazymake](https://github.com/rshelekhov/lazymake)
- [DBeaver](https://dbeaver.io)
- [Posting](https://github.com/darrenburns/posting) - terminal API client

### System monitoring & CLI utilities

- [btop](https://github.com/aristocratos/btop)
- [gdu](https://github.com/dundee/gdu)
- [yazi](https://yazi-rs.github.io)
- [try](https://github.com/binpash/try) - preview a command's effect in a sandbox before running it live
- [tldr](https://tldr.sh)
- [fastfetch](https://github.com/fastfetch-cli/fastfetch)
- [topgrade](https://github.com/topgrade-rs/topgrade) - updates everything in one shot (`up` alias); see `.config/topgrade.toml` for the custom steps it also runs (Eget binaries, `bw-update`, and the Kore Package Manager below)
- [bluetui](https://github.com/pythops/bluetui) - Bluetooth TUI
- [nmrs-tui](https://github.com/y2w8/nmrs-tui) - Wi-Fi TUI

### Package management

- [eget](https://github.com/zyedidia/eget) - installs prebuilt binaries straight from GitHub releases (see `.eget.toml`)
- [Flatpak](https://flatpak.org)
- [mise](https://mise.jdx.dev) - runtime/tool version manager
- [pipx](https://pipx.pypa.io)
- [pnpm](https://pnpm.io)
- [kpm](https://github.com/ezequielgk/Kore-Package-Manager/) - personal "Kore Package Manager", invoked as `~/.local/bin/kpm -u` from `topgrade.toml`.

### Virtualization & hacking

- [QEMU](https://www.qemu.org) + [virt-manager](https://virt-manager.org) + [libvirt](https://libvirt.org) (`vm-on`/`vm-off` aliases)
- BlackArch VM for penetration testing
- Windows 10 LTS VM for application testing/compatibility

### Containers & printing

- [Podman](https://podman.io) (`pod-on`/`pod-off` aliases)
- [CUPS](https://www.cups.org) + `cups-browsed` (`cups-on`/`cups-off` aliases)

---

## Legacy (unmaintained, X11 only)

Kept for reference only - not part of the Wayland/Sway setup and not required for a fresh install unless you specifically want the old i3 config:

- i3wm, i3blocks-color, i3lock-color
- Rofi - both the X11 build used by the old i3 setup and the Wayland for previously used by `sway-tab.sh` (see [SCRIPTS.md](SCRIPTS.md)); full replaced by `fzf` everywhere
- Vifm
- Swaylock
