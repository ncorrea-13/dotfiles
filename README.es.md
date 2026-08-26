<div align="center">

# dotfiles

**Config personal de Linux para un puesto Devuan + OpenRC + Sway**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Shell](https://img.shields.io/badge/Shell-Zsh-89e051?logo=gnubash&logoColor=white)](https://www.zsh.org)
[![WM](https://img.shields.io/badge/WM-Sway-1793D1?logo=wayland&logoColor=white)](https://swaywm.org)
[![Editor](https://img.shields.io/badge/Editor-Neovim%20%2F%20LazyVim-57A143?logo=neovim&logoColor=white)](https://www.lazyvim.org)

</div>

---

Colección de dotfiles para una sesión Wayland/Sway en Devuan con OpenRC. Se symlinkean directo a `$HOME` y `$HOME/.config` con `scripts/install.sh` en una máquina nueva. Existió un setup previo de Xorg + i3; está archivado y deprecado en `archive/`.

_[Read in English](README.md)_

## Stack

| Capa | Tecnología |
| --- | --- |
| Init system | OpenRC (Devuan) |
| Compositor / WM | Sway (Wayland) |
| Shell | Zsh |
| Terminal | WezTerm |
| Editor | Neovim + LazyVim |
| Multiplexor | Zellij |
| Gestor de archivos | Yazi (archivado: vifm) |
| Barra / notificaciones | Waybar, dunst |
| Descarga de paquetes | eget (`.eget.toml`) |
| Bloqueo de pantalla | rustlock-script |

## Quick Start

```bash
git clone git@github.com:ncorrea-13/dotfiles.git ~/dotfiles
cd ~/dotfiles
./scripts/install.sh        # pregunta antes de symlinkear, backupea archivos existentes
# o sin prompt:
./scripts/install.sh -y
```

`install.sh` symlinkea cada dir bajo `.config/` más `.zshrc`, `.alias`, `.eget.toml`, `.start-sway.sh` a `$HOME` (los archivos existentes se mueven a `*.bak-<timestamp>`). Solo cablea la config, instalá los programas primero, ver [docs/PERSONALPROGRAMS.es.md](docs/PERSONALPROGRAMS.es.md). Reiniciá la sesión después.

## Estructura del Proyecto

```
.config/          # targets de symlink: sway, nvim, wezterm, zellij, waybar, dunst, btop, ...
scripts/
├── install.sh          # symlinkea configs a $HOME
├── dotfiles.sh          # helper del repo
├── appimage-manager     # gestiona programas personales AppImage
├── bw-update             # helper de actualización de Bitwarden CLI
├── discordDownloader
└── rustlock-script
docs/              # KEYBINDINGS, SCRIPTS, PERSONALPROGRAMS (+ variantes .es)
archive/           # setup deprecado de Xorg/i3, guardado como referencia
screenshots/        # capturas del desktop en Devuan
.zshrc, .alias, .eget.toml, .start-sway.sh   # dotfiles symlinkeados a la raíz de $HOME
```

## Documentación

| Documento | Contenido |
| --- | --- |
| [docs/KEYBINDINGS.es.md](docs/KEYBINDINGS.es.md) | Todos los keybindings y alias/funciones de Zsh |
| [docs/SCRIPTS.es.md](docs/SCRIPTS.es.md) | Qué hace cada script en `.config/sway/scripts/` y `scripts/` |
| [docs/PERSONALPROGRAMS.es.md](docs/PERSONALPROGRAMS.es.md) | Programas personales necesarios para una instalación nueva |

## Capturas

![Apps 1](screenshots/Devuan/Apps_1.png)
![Apps 2](screenshots/Devuan/Apps_2.png)
![Apps 3](screenshots/Devuan/Apps_3.png)
![Apps 4](screenshots/Devuan/Apps_4.png)
![Rustlock](screenshots/Devuan/Rustlock.jpg)

## Licencia

- **Configs:** [MIT License](https://opensource.org/licenses/MIT)
- **LazyVim:** [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0.html)

Cumplí con ambas licencias al usar o redistribuir este repo. Texto completo en [LICENSE](LICENSE).

---

_Mendoza, Argentina - Nicolás Correa ([ncorrea-13](https://github.com/ncorrea-13))_
