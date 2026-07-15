# Referencia de Scripts

_[Read in English](SCRIPTS.md)_

Este repositorio incluye dos tipos de scripts de shell:

- **`.config/sway/scripts/`** — herramientas interactivas conectadas a atajos de Sway/Waybar. La mayoría son selectores con `fzf`, y varias se lanzan dentro de un popup flotante de Wezterm (ver [KEYBINDINGS.es.md](KEYBINDINGS.es.md) para los atajos exactos y el perfil del popup).
- **`scripts/`** — scripts independientes de instalación/mantenimiento y los wrappers de la pantalla de bloqueo. Se espera que estén disponibles en el `$PATH` (por ejemplo, enlazados simbólicamente a `~/.local/bin`) con su propio nombre, ya que `variables` y otros scripts los llaman por nombre directo (`rustlock-script`, etc.).

---

## `.config/sway/scripts/`

### `app-launcher.sh`

Lanzador de aplicaciones personalizado. Parsea cada archivo `.desktop` de los directorios de aplicaciones de usuario/sistema, se queda con el primer par `Name=`/`Exec=` de cada archivo, y ofrece la lista a través de `fzf`. A la línea `Exec=` elegida se le quitan los códigos de campo del desktop (`%f %F %u %U %i %c %k`) y se lanza en modo detached para que sobreviva aunque el proceso del lanzador termine.
**Depende de:** `fzf`, `awk`, `bash`.

### `clipboard-tui.sh`

Interfaz `fzf` para el historial del portapapeles. Lista las entradas de `cliphist list`, permite elegir una y la vuelve a copiar al portapapeles de Wayland con `wl-copy`.
**Depende de:** `cliphist`, `fzf`, `wl-copy`.

### `keybinds-tui.sh`

Genera la lista de atajos en vivo. Parsea `.config/sway/variables` en busca de definiciones `set $var` y cada archivo referenciado desde `keybindings/` en la config principal de Sway, sustituye las variables, humaniza los nombres de los modificadores (`Mod4`→`Super`, `Mod1`→`Alt`), y renderiza una lista coloreada y por secciones a través de `less`. Lee la config _en vivo_ en vez de una copia estática.
**Depende de:** `awk`, `grep`, `less`.

### `lock.sh`

Demonio de inactividad y suspensión, iniciado al arrancar Sway. Corre `swayidle` con cuatro disparadores: bloquear la pantalla y borrar la sesión cacheada de Bitwarden tras 10 minutos de inactividad, apagar las salidas (`dpms off`) 10 segundos después de eso, volver a encenderlas al reanudar, y bloquear inmediatamente antes de suspender. La pantalla de bloqueo en sí se delega a [`rustlock-script`](#rustlock-script--swaylock-script--i3lock-script).
**Depende de:** `swayidle`, `bw` (CLI de Bitwarden), `rustlock-script`.

### `nchat-picker.sh`

Selector de cuentas para `nchat`. Permite elegir una cuenta de mensajería (Telegram, Signal, WhatsApp personal/laboral) y abre `nchat` apuntando al directorio de configuración de esa cuenta dentro de un popup flotante de Wezterm. Si ya hay una ventana de `nchat` abierta con la _misma_ cuenta, simplemente se la vuelve a mostrar desde el scratchpad; si está abierta con una cuenta _distinta_, primero se mata la instancia anterior. Recuerda la última cuenta elegida en `~/.cache/nchat_account`.
**Depende de:** `fzf`, `swaymsg`, `jq`, `wezterm`.

### `powermenu.sh`

Menú `fzf` para apagar / reiniciar / hibernar / suspender / cerrar sesión / bloquear; cada acción destructiva queda protegida detrás de una confirmación Sí/No. Suspender además pausa `mpc` y mutea ALSA antes de llamar a suspend. Las acciones de sesión pasan por `elogind`.
**Depende de:** `fzf`, `elogind`, opcionalmente `mpc`/`amixer`.

### `scratchpad-toggle.sh`

Helper detrás de cada lanzador "kept alive". Dado un `app_id` y un comando, revisa si ya existe una ventana con ese `app_id` en el árbol de Sway: si es así, solo la muestra desde el scratchpad; si no, ejecuta (`exec`) el comando para lanzarla de cero. Esto es lo que hace que `$mod+m`, `$mod+Shift+b`, `$mod+u` y `$mod+Shift+d` alternen una única instancia en vez de crear duplicados.
**Depende de:** `swaymsg`, `jq`.

### `screenshot-tui.sh`

Herramienta de capturas y grabación de pantalla con `fzf` para elegir captura de área/ventana/pantalla completa, y luego copiar al portapapeles o guardar en archivo (`~/Pictures/Screenshots`); o iniciar/detener una grabación de pantalla (`~/Videos/Screencasts`) vía `wf-recorder`. Mientras se está grabando, al presionar el atajo de nuevo, la detiene. Envía una notificación de escritorio al terminar.
**Depende de:** `fzf`, `grim`, `slurp`, `wf-recorder`, `notify-send`, `wl-copy`.

### `screen-tui.sh`

Selector de disposición de monitores. Detecta una segunda salida conectada además del panel integrado `eDP-1` y permite elegir por búsqueda difusa entre Solo notebook / Solo monitor / Dualscreen, aplicando resolución y posición vía `swaymsg output`.
**Depende de:** `swaymsg`, `jq`, `fzf`, `notify-send`.

> El nombre de la salida del notebook (`eDP-1`) y las resoluciones están hardcodeadas.

### `sway-tab.sh`

Selector de ventanas. Recorre el árbol de Sway armando una lista plana de `[workspace] app_id` por cada ventana, y salta al workspace de la que elijas mediante `fzf`.
**Depende de:** `swaymsg`, `jq`, `fzf`.

---

## `scripts/` (instalación y mantenimiento)

### `bw-tui`

Selector de contraseñas de la CLI de Bitwarden. Ha migrado a su propio proyecto ([bw-tui](https://github.com/ncorrea-13/bw-tui))

### `bw-update`

Actualizador puntual para el binario de la CLI de Bitwarden: obtiene el último tag `cli-v*` desde la API de releases de GitHub de `bitwarden/clients`, descarga el zip de Linux correspondiente, e instala `bw` en `~/.local/bin`.
**Depende de:** `curl`, `unzip`.

### `discordDownloader`

Instalador/actualizador de Discord para sistemas basados en Debian, requiere root: descarga el `.deb` oficial, lo instala vía `dpkg`/`apt`, lanza Discord una vez como el usuario que invocó el script recuperando el entorno Wayland/X11 de su sesión activa, y por último instala BetterDiscord
**Depende de:** `wget`, `dpkg`/`apt`, `doas`/`sudo`, `bdcli` (CLI de
BetterDiscord, se espera en `~/.local/bin/bdcli`).

### `dotfiles.sh`

Helper de sincronización inversa: copia las configuraciones _en vivo_ desde `~/.config` (`sway`, `waybar`, `dunst`, `btop`, `fastfetch`, `wezterm`, `zellij`, `cava`, `nvim`, `posting`, `mpv`) más `topgrade.toml` de vuelta a este repositorio (`~/Projects/things/dotfiles`). Está pensado para ejecutarse con `~/.config` como directorio de trabajo, como forma rápida de traer el estado actual de la máquina de vuelta al control de versiones antes de commitear.
**Depende de:** solo coreutils (`cp`).

### `rustlock-script`

Wrapper de pantalla de bloqueo alrededor de `rustlock`, preconfigurado con la paleta de colores de esta configuración. Es el que está conectado actualmente.
**Depende de:** `rustlock`.

---

## Legacy (sin mantenimiento, solo X11)

Se mantienen como referencia, igual que en [PERSONALPROGRAMS.md](PERSONALPROGRAMS.md#legacy-unmaintained-x11-only). No
están en uso en la configuración actual.

### `swaylock-script`

Wrapper de pantalla de bloqueo alrededor de `swaylock`, con la misma paleta de colores que `rustlock-script`.
**Depende de:** `swaylock-effects`.

### `i3lock-script`

Wrapper de pantalla de bloqueo alrededor de `i3lock`.
**Depende de:** `i3lock-fancy`.
