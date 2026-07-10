# Referencia de Atajos de Teclado y Alias

_[Read in English](KEYBINDINGS.md)_

Este documento cubre todos los atajos de teclado y alias de shell definidos en este repositorio de dotfiles: Sway, Wezterm, Zellij y los alias y funciones de Zsh en `.alias`.

> **`$mod+c`** muestra lista en vivo y con búsqueda, generada directamente desde la config de Sway (`.config/sway/scripts/keybinds-tui.sh`). Parsea `variables` y cada archivo de `keybindings/`, así que nunca queda desactualizada.

---

## 1. Sway (Gestor de Ventanas)

La config de Sway vive en `.config/sway/`, dividida entre `variables` y el directorio `keybindings/`.

### Teclas modificadoras

| Variable | Tecla                        |
| -------- | ---------------------------- |
| `$mod`   | `Mod4` (tecla Super/Windows) |
| `$alt`   | `Mod1` (Alt)                 |

También hay mapeadas teclas direccionales estilo Vim: `$left`=`h`, `$down`=`j`, `$up`=`k`, `$right`=`l`. Cada atajo direccional de abajo funciona **tanto** con las teclas Vim como con las flechas físicas.

### General (`keybindings/basics`)

| Atajo                   | Acción                                               |
| ----------------------- | ---------------------------------------------------- |
| `$mod+Shift+q`          | Cerrar la ventana                                    |
| `$mod+space`            | Lanzador de aplicaciones (`scripts/app-launcher.sh`) |
| `$mod+Shift+r`          | Recargar la config de Sway                           |
| `$mod+Shift+e`          | Salir de Sway (terminar la sesión)                   |
| `$alt+Ctrl+l`           | Bloquear la pantalla (`rustlock-script`)             |
| `$mod+slash`            | Selector de emojis (`smile`)                         |
| `$mod+p`                | Menú de apagado                                      |
| `$mod+tab`              | Ejecutar `sway-tab.sh` (gestión de ventanas)         |
| `$mod+comma`            | Ir al workspace anterior                             |
| `$mod+period`           | Ir al workspace siguiente                            |
| `$mod+s` ; `Print`      | Capturas de pantalla                                 |
| `XF86AudioRaiseVolume`  | Subir volumen 5%                                     |
| `XF86AudioLowerVolume`  | Bajar volumen 5%                                     |
| `XF86AudioMute`         | Silenciar/activar salida de audio                    |
| `XF86AudioMicMute`      | Silenciar/activar micrófono                          |
| `XF86MonBrightnessUp`   | Brillo +5%                                           |
| `XF86MonBrightnessDown` | Brillo −5%                                           |

El `floating_modifier` también es `$mod`. Cualquier ventana que esté flontando se puede mover si se mantiene `$mod` y se arrastrá con el mouse.

### Aplicaciones (`keybindings/apps`)

| Atajo         | Acción                                |
| ------------- | ------------------------------------- |
| `$mod+Return` | Lanzar terminal (Wezterm)             |
| `$mod+e`      | Lanzar el gestor de archivos (Thunar) |
| `$mod+d`      | Lanzar Discord                        |
| `$mod+n`      | Lanzar el navegador (LibreWolf)       |
| `$mod+o`      | Lanzar notas (Obsidian)               |
| `$mod+y`      | Lanzar YouTube (FreeTube)             |

Sway también asigna automáticamente aplicaciones conocidas a workspaces
fijos al abrirlas, así que siempre abren en el mismo lugar:

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

### Lanzadores — utilidades TUI flotantes (`keybindings/launchers`)

Todos estos abren un pequeño popup flotante de Wezterm (vía
`wezterm/tui-popup.lua`) corriendo una herramienta TUI específica. Algunos
se mantienen "vivos" — en vez de cerrarse, se mandan al **scratchpad** vía
`scratchpad-toggle.sh`, así que volver a presionar el atajo simplemente
muestra/oculta la instancia que ya está corriendo en lugar de relanzarla.

| Atajo                          | Acción                                           | ¿Se mantiene vivo? |
| ------------------------------ | ------------------------------------------------ | ------------------ |
| `$mod+m`                       | Spotify (Ncspot)                                 | ✅                  |
| `$mod+w`                       | Wi-Fi (`nmrs-tui`)                               |                    |
| `$mod+b`                       | Bluetooth (`bluetui`)                            |                    |
| `$mod+v`                       | Portapapeles (`clipboard-tui.sh` con `cliphist`) |                    |
| `$mod+Shift+b`                 | Bitwarden                                        | ✅                  |
| `$mod+u`                       | Topgrade                                         | ✅                  |
| `$mod+t`                       | Btop                                             |                    |
| `$mod+Shift+y`                 | YouTube (`ytsurf`)                               |                    |
| `$mod+Shift+n`                 | Nchat (Telegram/Signal/WhatsApp)                 |                    |
| `$mod+Shift+d`                 | Discord (Concord)                                | ✅                  |
| `$mod+Shift+o`                 | Ekphos                                           |                    |
| `$mod+Shift+t`                 | Localsend (LocalSend)                            |                    |
| `$mod+Shift+f`                 | Auto-cpufreq                                     |                    |
| `$mod+c`                       | Keybindings                                      |                    |
| `XF86Display` / `$mod+Shift+p` | Control de monitores                             |                    |

### Movimiento y layout (`keybindings/movement`)

| Atajo                                        | Acción                                                   |
| -------------------------------------------- | -------------------------------------------------------- |
| `$mod+h/j/k/l` o flechas                     | Mover el foco izquierda/abajo/arriba/derecha             |
| `$mod+Shift+h/j/k/l` o `$mod+Shift+`+flechas | Mover la ventana enfocada izquierda/abajo/arriba/derecha |
| `$mod+alt+s`                                 | Poner el layout en stacking                              |
| `$mod+alt+w`                                 | Poner el layout en tabbed                                |
| `$mod+f`                                     | Alternar pantalla completa                               |
| `$mod+Shift+space`                           | Alternar flotante para la ventana enfocada               |
| `$mod+a`                                     | Enfocar el contenedor padre                              |

### Workspaces (`keybindings/workspaces`)

| Atajo                         | Acción                                      |
| ----------------------------- | ------------------------------------------- |
| `$mod+1`…`$mod+0`             | Ir al workspace 1–10                        |
| `$mod+Shift+1`…`$mod+Shift+0` | Mover la ventana enfocada al workspace 1–10 |
| `$mod+Shift+m`                | Mover el workspace actual al otro monitor   |

### Modo de redimensionado (`keybindings/resizing`)

| Atajo                         | Acción         |
| ----------------------------- | -------------- |
| `$mod+r`                      | Redimencionar  |
| `h`/`←`                       | Reducir ancho  |
| `l`/`→`                       | Aumentar ancho |
| `k`/`↑`                       | Reducir alto   |
| `j`/`↓`                       | Aumentar alto  |
| `Return`, `Escape` o `$mod+r` | Salir del modo |

### Scratchpad (`keybindings/scratchpad`)

| Atajo               | Acción                              |
| ------------------- | ----------------------------------- |
| `$mod+Shift+Return` | Mandar la ventana al scratchpad     |
| `$mod+minus`        | Mostrar las ventanas del scratchpad |

---

## 2. Wezterm (Emulador de Terminal)

Los atajos de tabs siguen funcionando por teclado unicamente cuando está abierto Wezterm.

| Atajo              | Acción                                  |
| ------------------ | --------------------------------------- |
| `Ctrl+Shift+n`     | Crear un tab nuevo                      |
| `Ctrl+Shift+x`     | Cerrar el tab actual (sin confirmación) |
| `Ctrl+Shift+h`     | Activar el tab anterior                 |
| `Ctrl+Shift+l`     | Activar el tab siguiente                |
| `Ctrl+Shift+1`…`4` | Saltar al tab 1–4                       |

También existe `.config/wezterm/tui-popup.lua`, un perfil reducido usado exclusivamente para lanzar los lanzadores.

---

## 3. Zellij (Multiplexor de Terminal)

Zellij arranca en modo `locked` donde las teclas pasan directo a la shell. Con **`Ctrl+g`** se desbloquea al modo `normal` y se accede a los atajos de abajo; presioná `Ctrl+g` de nuevo para volver a bloquear.

### Cambios de modo (disponibles una vez desbloqueado)

| Tecla    | Entra al modo   |
| -------- | --------------- |
| `p`      | Modo pane       |
| `t`      | Modo tab        |
| `r`      | Modo resize     |
| `s`      | Modo scroll     |
| `o`      | Modo session    |
| `m`      | Modo move       |
| `Ctrl+q` | Salir de Zellij |

### Globales (funcionan en `normal` y `locked`, sin cambiar de modo)

| Tecla                      | Acción                                  |
| -------------------------- | --------------------------------------- |
| `Alt+h/j/k/l` o `Alt+←↓↑→` | Mover el foco                           |
| `Alt+n`                    | Panel nuevo                             |
| `Alt+f`                    | Alternar paneles flotantes              |
| `Alt+ +` / `Alt+ -`        | Aumentar/reducir tamaño del panel       |
| `Alt+[` / `Alt+]`          | Rotar al swap layout anterior/siguiente |
| `Alt+i` / `Alt+o`          | Mover el tab a la izquierda/derecha     |
| `Alt+y`                    | Abrir el plugin "zellij-forgot"         |

### Modo pane (`p`)

| Tecla               | Acción                                            |
| ------------------- | ------------------------------------------------- |
| `h/j/k/l` o flechas | Enfocar panel izquierda/abajo/arriba/derecha      |
| `n`                 | Panel nuevo                                       |
| `d`                 | Panel nuevo abajo                                 |
| `r`                 | Panel nuevo a la derecha                          |
| `x`                 | Cerrar el panel enfocado                          |
| `f`                 | Alternar pantalla completa para el panel enfocado |
| `e`                 | Alternar panel embebido/flotante                  |
| `w`                 | Alternar todos los paneles flotantes              |
| `c`                 | Renombrar panel                                   |
| `z`                 | Alternar marcos de los paneles                    |

### Modo tab (`t`)

| Tecla               | Acción                                              |
| ------------------- | --------------------------------------------------- |
| `h/j/k/l` o flechas | Tab anterior/siguiente                              |
| `1`–`9`             | Saltar al tab N                                     |
| `n`                 | Tab nuevo                                           |
| `x`                 | Cerrar tab                                          |
| `r`                 | Renombrar tab                                       |
| `s`                 | Alternar entrada sincronizada entre paneles del tab |
| `b`                 | Sacar el panel a un tab nuevo                       |
| `[` / `]`           | Sacar el panel a la izquierda/derecha               |

### Modo resize (`r`)

| Tecla                  | Acción                   |
| ---------------------- | ------------------------ |
| `h/j/k/l` o flechas    | Crecer en esa dirección  |
| `H/J/K/L` (mayúsculas) | Achicar en esa dirección |
| `+` / `-` / `=`        | Aumentar/reducir         |

### Modo move (`m`)

| Tecla               | Acción                                   |
| ------------------- | ---------------------------------------- |
| `h/j/k/l` o flechas | Mover el panel enfocado en esa dirección |
| `n`                 | Ir al siguiente panel                    |
| `p`                 | Ir al panel anterior                     |

### Modo scroll (`s`)

| Tecla             | Acción                                   |
| ----------------- | ---------------------------------------- |
| `j`/`k`           | Bajar/subir una línea                    |
| `h`/`l`           | Página arriba/abajo                      |
| `Ctrl+f`/`Ctrl+b` | Página abajo/arriba                      |
| `u`/`d`           | Media página arriba/abajo                |
| `f`               | Entrar al modo búsqueda                  |
| `e`               | Editar el scrollback en `$EDITOR` (nvim) |
| `Ctrl+c`          | Ir al final y volver a bloquear          |

### Modo session (`o`)

| Tecla | Acción                       |
| ----- | ---------------------------- |
| `w`   | Abrir el gestor de sesiones  |
| `p`   | Abrir el gestor de plugins   |
| `c`   | Abrir la UI de configuración |
| `d`   | Desconectar la sesión        |

---

## 4. Neovim

Neovim es una distribución [LazyVim](https://www.lazyvim.org/), así que hereda todos los keymaps `<leader>` por defecto de LazyVim (el leader es `space`). Esta config, además de los plugins que ya administra LazyVim, agrega:

| Atajo          | Acción                                             |
| -------------- | -------------------------------------------------- |
| `<leader>r`    | Renombrar vía LSP (inline, con `live_rename.nvim`) |
| `<leader>R`    | Renombrar vía LSP con un carácter extra de padding |
| `<leader><F5>` | Alternar Undotree                                  |

Para el set completo de keymaps por defecto, ver la
[documentación de keymaps de LazyVim](https://www.lazyvim.org/keymaps).

---

## 5. Alias y Funciones de Shell (`.alias`)

Se cargan desde `.zshrc`. El shell es Zsh con `oh-my-zsh` + `powerlevel10k`.

### Funciones

| Nombre     | Propósito                                                                                                                  |
| ---------- | -------------------------------------------------------------------------------------------------------------------------- |
| `rc <cmd>` | Ejecuta `<cmd>` como root (vía `doas`) con un `PATH` limpio y predecible. El wrapper equivalente a `sudo` en este sistema. |
| `fuck`     | Carga y ejecuta [`thefuck`](https://github.com/nvbn/thefuck) de forma perezosa, solo en la primera invocación.             |

### Reemplazos de utilidades core

| Alias | Reemplaza a | Con                                                   |
| ----- | ----------- | ----------------------------------------------------- |
| `ls`  | `ls`        | [`lsd`](https://github.com/lsd-rs/lsd)                |
| `cat` | `cat`       | [`batcat`](https://github.com/sharkdp/bat)            |
| `cd`  | `cd`        | [`zoxide`](https://github.com/ajeetdsouza/zoxide)     |
| `up`  | —           | [`topgrade`](https://github.com/topgrade-rs/topgrade) |

### Mensajería (nchat)

| Alias           | Propósito                                                                |
| --------------- | ------------------------------------------------------------------------ |
| `telegram`      | Abre [nchat](https://github.com/d99kris/nchat) con el perfil de Telegram |
| `signal`        | Abre nchat con el perfil de Signal                                       |
| `whatsapp`      | Abre nchat con el perfil personal de WhatsApp                            |
| `whatsapp-work` | Abre nchat con el perfil laboral de WhatsApp                             |

### Utilidades varias

| Alias/Función | Propósito                                                                                           |
| ------------- | --------------------------------------------------------------------------------------------------- |
| `concord`     | Cliente TUI de Discord, lanzado con el directorio de plugins ALSA correcto para el audio            |
| `pomodoro`    | Temporizador Pomodoro de 45 minutos de trabajo / 15 de descanso, 4 ciclos (`tomatoshell`)           |
| `health`      | Muestra frecuencia de CPU, temperatura del paquete y estado/ciclos de la batería en un solo comando |
| `bw-auth`     | Desbloquea la CLI de Bitwarden y exporta la clave de sesión (`BW_SESSION`)                          |

### Gestión de servicios OpenRC

Este sistema corre OpenRC (sin systemd), así que los servicios se manejan
con `rc` + `rc-service`/`rc-update`/`rc-status`:

| Alias                                | Propósito                                                                  |
| ------------------------------------ | -------------------------------------------------------------------------- |
| `rcs`                                | `rc-status` — muestra el estado de los servicios                           |
| `rcu`                                | `rc-update` — gestiona la habilitación de servicios                        |
| `rcsv`                               | `rc-service` — inicia/detiene/reinicia un servicio                         |
| `rclist`                             | Lista todos los servicios y sus runlevels, en modo verbose                 |
| `rccrash`                            | Lista los servicios que crashearon                                         |
| `cups-on` / `cups-off` / `cups-stat` | Inicia/detiene/verifica el stack de impresión (`cups`, `cups-browsed`)     |
| `vm-on` / `vm-off`                   | Inicia/detiene el stack de virtualización libvirt (`libvirtd`, `virtlogd`) |
| `pod-on` / `pod-off`                 | Inicia/detiene el servicio del socket de Podman                            |

### VM de Arch (BlackArch)

Una VM de libvirt usada para herramientas de seguridad:

| Alias         | Propósito                                                                                                 |
| ------------- | --------------------------------------------------------------------------------------------------------- |
| `arch-on`     | Inicia la VM `archlinux`                                                                                  |
| `arch-off`    | Apaga la VM `archlinux`                                                                                   |
| `arch-ssh`    | Se conecta por SSH a la VM (alias de host `arch-vm`)                                                      |
| `arch-status` | Lista todos los dominios de libvirt y su estado                                                           |
| `arch-work`   | Inicia la VM, espera hasta que obtenga IP por DHCP en `192.168.x.x`, y se conecta por SSH automáticamente |

---

## 6. Waybar (Barra de Estado)

Replica algunos de los atajos de los lanzadores de Sway como clicks del mouse en la barra, así que las mismas herramientas quedan accesibles sin el teclado:

| Módulo     | Acción al hacer click                               |
| ---------- | --------------------------------------------------- |
| Logo       | Abre `btop`                                         |
| Red        | Abre la TUI de Wi-Fi (`nmrs-tui`)                   |
| Bluetooth  | Abre la TUI de Bluetooth (`bluetui`)                |
| Power      | Abre la TUI del menú de energía                     |
| Workspaces | Hacé click en el ícono de un workspace para ir a él |
