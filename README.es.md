# Mis dotfiles personales de Linux

_[Read in English](README.md)_

Este repositorio contiene mi colección de dotfiles la cual utilizo en mi entorno de trabajo de Devuan con OpenRC.

> **Nota:** Esta configuración utiliza Wayland con Sway. Anteriormente existía una versión anterior para Xorg con i3. Actualmente se encuentra archivada y deprecada.

## Instalación

1. Cloná el repositorio:

   ```bash
   git clone https://github.com/ncorrea-13/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Movés los archivos de configuración a tu directorio `~/.config`:

   ```bash
   mv .config/* ~/.config/
   ```

   También podés mover solo la configuración que quieras importar:

   ```bash
   mv .config/nvim ~/.config/
   ```

3. Instalá las dependencias necesarias. Ver [docs/PERSONALPROGRAMS.es.md](docs/PERSONALPROGRAMS.es.md).
4. Reinicia la sesión para que los cambios tengan efecto.

## Documentación

- [docs/KEYBINDINGS.es.md](docs/KEYBINDINGS.es.md) - referencia completa de todos los atajos de teclado y de todos los alias/funciones de Zsh.
- [docs/SCRIPTS.es.md](docs/SCRIPTS.es.md) - qué hace cada script de `.config/sway/scripts/` y `scripts/`, y de qué depende.
- [docs/PERSONALPROGRAMS.es.md](docs/PERSONALPROGRAMS.es.md) - la lista de programas personales usados para que esta configuración funcione en una instalación nueva.

## Capturas de pantalla

![[screenshots/Sway/3-Zellij.png]](https://github.com/ncorrea-13/dotfiles/blob/main/screenshots/Sway/3-Zellij.png)

![](https://github.com/ncorrea-13/dotfiles/blob/main/screenshots/Sway/4-Browsers.png)

## Licencia

- **Configuraciones:** [Licencia MIT](https://opensource.org/licenses/MIT)
- **Lazyvim:** [Licencia Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0.html)

Por favor asegurate de cumplir con ambas licencias al usar y distribuir este repositorio.

Para más información, consultá el archivo [LICENSE](LICENSE) incluido en la raíz del repositorio.

_Mendoza, Argentina - Nicolás Correa ([ncorrea-13](https://github.com/ncorrea-13))_
