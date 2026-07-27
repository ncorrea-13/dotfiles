# My personal Linux dotfiles

_[Leer en español](README.es.md)_

This repository has my collection of dotfiles, the ones I use on my Devuan with OpenRC work environment.

> **Note:** This config uses Wayland with Sway. There was a previous version for Xorg with i3, but it is now archived and deprecated.

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/ncorrea-13/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Move the config files to your `~/.config` directory:

   ```bash
   mv .config/* ~/.config/
   ```

   You can also move only the config you want to import:

   ```bash
   mv .config/nvim ~/.config/
   ```

3. Install the needed dependencies. See [docs/PERSONALPROGRAMS.md](docs/PERSONALPROGRAMS.md).
4. Restart your session so the changes take effect.

## Documentation

- [docs/KEYBINDINGS.md](docs/KEYBINDINGS.md) - full reference of every keybinding and every Zsh alias/function.
- [docs/SCRIPTS.md](docs/SCRIPTS.md) - what every script in `.config/sway/scripts/` and `scripts/` does, and what it depends on.
- [docs/PERSONALPROGRAMS.md](docs/PERSONALPROGRAMS.md) - the list of personal programs used so this config works on a fresh install.

## Screenshots

![[screenshots/Devuan/Apps_1.png]](https://github.com/ncorrea-13/dotfiles/blob/main/screenshots/Devuan/Apps_1.png)
![[screenshots/Devuan/Apps_2.png]](https://github.com/ncorrea-13/dotfiles/blob/main/screenshots/Devuan/Apps_2.png)
![[screenshots/Devuan/Apps_3.png]](https://github.com/ncorrea-13/dotfiles/blob/main/screenshots/Devuan/Apps_3.png)
![[screenshots/Devuan/Apps_4.png]](https://github.com/ncorrea-13/dotfiles/blob/main/screenshots/Devuan/Apps_4.png)
![[screenshots/Devuan/Rustlock.png]](https://github.com/ncorrea-13/dotfiles/blob/main/screenshots/Devuan/Rustlock.jpg)

## License

- **Configs:** [MIT License](https://opensource.org/licenses/MIT)
- **Lazyvim:** [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0.html)

Please make sure to comply with both licenses when using and distributing this repository.

For more information, check the [LICENSE](LICENSE) file included in the root of the repository.

_Mendoza, Argentina - Nicolás Correa ([ncorrea-13](https://github.com/ncorrea-13))_
