# Programas Personales

_[Read in English](PERSONALPROGRAMS.md)_

Lista de todos los programas que referencian estos dotfiles, para poder instalarlos en una máquina nueva. Dividida en dos:

- **Esenciales** — la sesión de escritorio en sí (gestor de ventanas, barra, pantalla de bloqueo, portapapeles, shell, etc.) no funciona sin estos.
- **Personales** — elecciones de aplicaciones específicas (navegadores, clientes de chat, entretenimiento, herramientas de desarrollo...). Cualquiera de estos se puede cambiar por tu favorito y el resto de la configuración sigue funcionando.

---

## Esenciales

### Sesión Wayland y gestor de ventanas

- [SwayFX](https://github.com/WillPower3309/swayfx) — fork de Sway con blur, esquinas redondeadas y sombras (usado para `corner_radius`, `blur`, `shadows` en `variables`)
- [Waybar](https://github.com/Alexays/Waybar) — barra de estado
- [autotiling](https://github.com/nwg-piotr/autotiling) — layout de tiling automático para Sway
- [sway-fader](https://github.com/mgnsk/sway-fader) — efecto de fade-in en ventanas nuevas/enfocadas
- [swaybg](https://github.com/swaywm/swaybg) — wallpaper
- [swayidle](https://github.com/swaywm/swayidle) — manejo de inactividad (`lock.sh`)
- [Dunst](https://github.com/dunst-project/dunst) — demonio de notificaciones
- [mate-polkit](https://github.com/mate-desktop/mate-polkit) — agente de autenticación polkit (prompts de huella/contraseña)
- [greetd](https://git.sr.ht/~kennylevinsen/greetd/) — demonio de login manager
- [rustlock](https://github.com/JorySeverijnse/rustlock) — la pantalla de bloqueo actualmente en uso

### Portapapeles y capturas

- [wl-clipboard](https://github.com/bugaevc/wl-clipboard) (`wl-copy`/`wl-paste`)
- [cliphist](https://github.com/sentriz/cliphist) — historial de portapapeles
- [grim](https://sr.ht/~emersion/grim/) + [slurp](https://github.com/emersion/slurp) — capturas de pantalla
- [wf-recorder](https://github.com/ammen99/wf-recorder) — grabación de pantalla

### Audio, brillo y energía

- [WirePlumber](https://gitlab.freedesktop.org/pipewire/wireplumber) (`wpctl`) + [PipeWire](https://pipewire.org) (`pactl`)
- [brightnessctl](https://github.com/Hummer12007/brightnessctl)
- [auto-cpufreq](https://github.com/AdnanHodzic/auto-cpufreq)

### Shell y terminal

- [Wezterm](https://wezterm.org) — emulador de terminal
- [Zsh](https://www.zsh.org) + [Oh My Zsh](https://ohmyz.sh) + [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) + [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting)
- [zoxide](https://github.com/ajeetdsouza/zoxide) (`cd` → `z`)
- [lsd](https://github.com/lsd-rs/lsd) (`ls`)
- [bat](https://github.com/sharkdp/bat) (`cat`/`batcat`)
- [doas / OpenDoas](https://github.com/Duncaen/OpenDoas) — reemplazo de `sudo`, usado en todos lados vía el alias `rc`

### Pickers y lanzador

- [fzf](https://github.com/junegunn/fzf) — impulsa casi todos los selectores TUI de `.config/sway/scripts/`
- [jq](https://jqlang.github.io/jq/) — parseo de JSON para la salida de `swaymsg` en varios scripts

### Sistema base y archivos

- [OpenRC](https://github.com/OpenRC/openrc) — gestión de servicios (usado a través de los wrappers de `.alias`, `rc rc-status`, etc.)
- [Syncthing](https://syncthing.net) — sincronización de archivos, iniciado al arrancar Sway
- [Thunar](https://docs.xfce.org/xfce/thunar/start) — gestor de archivos (`$mod+e`)

### Fuentes y cursor

- [Nerd Fonts](https://www.nerdfonts.com) — JetBrainsMono Nerd Font (Sway/Waybar) y HackNerdFont (Wezterm); sin estas, los íconos se rompen en todos lados
- [Oreo Cursors](https://github.com/varlesh/oreo-cursors) — tema de cursor (`$cursor_theme oreo`)

---

## Personales

### Navegadores

- [Mullvad Browser](https://mullvad.net/en/browser)
- [LibreWolf](https://librewolf.net)

### Mensajería y social

- [Nchat](https://github.com/d99kris/nchat) — cliente TUI de Telegram/Signal/WhatsApp
- Discord, [Concord](https://github.com/chojs23/concord) (cliente TUI de Discord), [bdcli](https://github.com/BetterDiscord/cli) (instalador de BetterDiscord, ejecutado desde `discordDownloader`)
- [Jocalsend](https://git.kittencollective.com/nebkor/joecalsend) + [LocalSend](https://github.com/localsend/localsend)

### Entretenimiento

- [FreeTube](https://freetubeapp.io)
- [Hayase](https://github.com/hayase-app/ui) (antes Miru)
- [Stremio](https://www.stremio.com)
- [ncspot](https://github.com/hrkfdn/ncspot) — cliente TUI de Spotify
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) + [ytsurf](https://github.com/Stan-breaks/ytsurf) + [mpv](https://mpv.io)

### Productividad

- [Obsidian](https://obsidian.md) + [Ekphos](https://github.com/hanebox/ekphos) (terminal, inspirado en Obsidian) + [Basalt](https://github.com/erikjuhani/basalt) (TUI, inspirado en Obsidian)
- [Bitwarden CLI](https://bitwarden.com/help/cli/) + `bitwarden-tui` (el front-end en `fzf` de este repo, ver [SCRIPTS.es.md](SCRIPTS.es.md))
- [ONLYOFFICE](https://www.onlyoffice.com)
- [Zathura](https://pwmt.org/projects/zathura/) — visor de PDF
- [tomatoshell](https://github.com/LytixDev/tomatoshell) — temporizador Pomodoro
- [tennis](https://github.com/gurgeous/tennis)

### Desarrollo

- [Neovim](https://neovim.io) ([LazyVim](https://www.lazyvim.org))
- [Vim](https://www.vim.org) — editor de respaldo
- [Zellij](https://zellij.dev) — multiplexor de terminal
- [lazygit](https://github.com/jesseduffield/lazygit), [lazydocker](https://github.com/jesseduffield/lazydocker), [lazymake](https://github.com/rshelekhov/lazymake)
- [DBeaver](https://dbeaver.io)
- [Posting](https://github.com/darrenburns/posting) — cliente de API en terminal

### Monitoreo del sistema y utilidades CLI

- [btop](https://github.com/aristocratos/btop)
- [gdu](https://github.com/dundee/gdu)
- [yazi](https://yazi-rs.github.io)
- [try](https://github.com/binpash/try) — previsualiza el efecto de un comando en un sandbox antes de correrlo en vivo
- [tldr](https://tldr.sh)
- [fastfetch](https://github.com/fastfetch-cli/fastfetch)
- [topgrade](https://github.com/topgrade-rs/topgrade) — actualiza todo de una (alias `up`); ver `.config/topgrade.toml` para los pasos personalizados que también corre (binarios de Eget, `bw-update`, y el Kore Package Manager de abajo)
- [bluetui](https://github.com/pythops/bluetui) — TUI de Bluetooth
- [nmrs-tui](https://github.com/y2w8/nmrs-tui) — TUI de Wi-Fi

### Gestión de paquetes

- [eget](https://github.com/zyedidia/eget) — instala binarios precompilados directo desde releases de GitHub (ver `.eget.toml`)
- [Flatpak](https://flatpak.org)
- [mise](https://mise.jdx.dev) — gestor de versiones de runtimes/herramientas
- [pipx](https://pipx.pypa.io)
- [pnpm](https://pnpm.io)
- [kpm](https://github.com/ezequielgk/Kore-Package-Manager/) — "Kore Package Manager" personal, invocado como `~/.local/bin/kpm -u` desde `topgrade.toml`.

### Virtualización y hacking

- [QEMU](https://www.qemu.org) + [virt-manager](https://virt-manager.org) + [libvirt](https://libvirt.org) (alias `vm-on`/`vm-off`)
- VM de BlackArch para pentesting
- VM de Windows 10 LTS para pruebas de aplicaciones/compatibilidad

### Contenedores e impresión

- [Podman](https://podman.io) (alias `pod-on`/`pod-off`)
- [CUPS](https://www.cups.org) + `cups-browsed` (alias `cups-on`/`cups-off`)

---

## Legacy (sin mantenimiento, solo X11)

Se mantienen como referencia — no forman parte de la configuración Wayland/Sway y no son necesarios para una instalación nueva, a menos que específicamente quieras la config vieja de i3:

- i3wm, i3blocks-color, i3lock-color
- Rofi — tanto el build de X11 usado por la vieja config de i3 como el fork de Wayland usado antes por `sway-tab.sh` (ver [SCRIPTS.es.md](SCRIPTS.es.md)); reemplazado por completo por `fzf` en todos lados
- Vifm
- Swaylock
