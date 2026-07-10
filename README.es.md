# Mis dotfiles personales de Linux

*[Read in English](README.md)*

¡Bienvenido a mi colección de dotfiles! Acá vas a encontrar mis configuraciones personales para herramientas esenciales de Linux.

> **Nota:** Está pensado para usar Wayland con Sway. También hay configuraciones para i3 e i3blocks, pero actualmente no tienen mantenimiento porque ya no uso Xorg.

## Instalación

Para instalar estas configuraciones en tu sistema, seguí estos pasos:

1. Cloná el repositorio en tu directorio home:

    ```bash
    git clone https://github.com/ncorrea-13/dotfiles.git ~/dotfiles
    ```

2. Navegá al directorio del repositorio:

    ```bash
    cd ~/dotfiles
    ```

3. Movés los archivos de configuración del repositorio a tu directorio `~/.config`:

    ```bash
    mv .config/* ~/.config/
    ```

    También podés mover solo la configuración que quieras importar:

    ```bash
    mv .config/nvim ~/.config
    ```

    **Nota**: Asegurate de que el directorio `~/.config` exista antes de mover los directorios.

4. Instalá las dependencias necesarias. Ver [docs/PERSONALPROGRAMS.es.md](docs/PERSONALPROGRAMS.es.md) para la lista completa de programas de los que depende esta configuración.
5. Reiniciá las aplicaciones o tu sesión de usuario para que los cambios tengan efecto.

## Documentación

- [docs/KEYBINDINGS.es.md](docs/KEYBINDINGS.es.md) — referencia completa de todos los atajos de teclado (Sway, Wezterm, Zellij, Neovim) y de todos los alias/funciones de Zsh.
- [docs/SCRIPTS.es.md](docs/SCRIPTS.es.md) — qué hace cada script de `.config/sway/scripts/` y `scripts/`, y de qué depende.
- [docs/PERSONALPROGRAMS.es.md](docs/PERSONALPROGRAMS.es.md) — la lista de programas personales usados para que esta configuración funcione en una instalación nueva.

## Capturas de pantalla

![[screenshots/Sway/3-Zellij.png]](https://github.com/ncorrea-13/dotfiles/blob/main/screenshots/Sway/3-Zellij.png)

![](https://github.com/ncorrea-13/dotfiles/blob/main/screenshots/Sway/4-Browsers.png)

## Sin systemd

Estas configuraciones son 100% compatibles con distribuciones sin systemd, ya que no dependen de systemctl, loginctl ni de otras herramientas específicas de systemd para la gestión de sesión o de servicios.

## Licencia

- **Configuraciones:** [Licencia MIT](https://opensource.org/licenses/MIT)
- **Lazyvim:** [Licencia Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0.html)

Por favor asegurate de cumplir con ambas licencias al usar y distribuir este repositorio.

Para más información, consultá el archivo [LICENSE](LICENSE) incluido en la raíz del repositorio.

*Mendoza, Argentina — Nicolás Correa ([ncorrea-13](https://github.com/ncorrea-13))*
