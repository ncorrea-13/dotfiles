# 💻 Nicolás Correa's Dotfiles 🎨

Welcome to my collection of dotfiles! Here you will find my personal configurations for essential Linux tools. 🚀

## 📂 Contents

- 🖥️ **i3** - Window manager configuration.
- 📊 **i3blocks** - Status bar configuration.
- 📈 **Btop++** - Resource monitor configuration.
- 🎵 **Cava** - Audio visualizer configuration.
- 🔔 **Dunst** - Notification service configuration.
- 🖼️ **Fastfetch** - System information tool configuration.
- 📝 **Neovim** - Custom configuration based on LazyVim.
- 🌫️ **Picom** - Window compositor configuration.
- 🚀 **Rofi** - Application launcher configuration.
- 📁 **Vifm** - Terminal file manager configuration.
- 🔲 **WezTerm** - Terminal emulator configuration.
- 🔍 **Zellij** - Terminal multiplexer configuration.

## ⚙️ Installation

To install these configurations on your system, follow these steps:

1. Clone the repository into your home directory:

    ```bash
    git clone https://github.com/ncorrea-13/dotfiles.git ~/dotfiles
    ```

2. Navigate to the repository directory:

    ```bash
    cd ~/dotfiles
    ```

3. Create symbolic links from the configuration files in the repository to your `~/.config` directory:

    ```bash
    ln -s ~/dotfiles/nvim ~/.config/nvim
    ln -s ~/dotfiles/wezterm ~/.config/wezterm
    ln -s ~/dotfiles/i3 ~/.config/i3
    ln -s ~/dotfiles/i3blocks ~/.config/i3blocks
    ln -s ~/dotfiles/rofi ~/.config/rofi
    ln -s ~/dotfiles/zellij ~/.config/zellij
    ln -s ~/dotfiles/picom.conf ~/.config/picom.conf
    ln -s ~/dotfiles/btop ~/.config/btop
    ln -s ~/dotfiles/cava ~/.config/cava
    ln -s ~/dotfiles/dunst ~/.config/dunst
    ln -s ~/dotfiles/fastfetch ~/.config/fastfetch/
    ln -s ~/dotfiles/vifm ~/.config/vifm
    ```

    **Note**: Ensure that the `~/.config` directory exists before creating symbolic links.

4. Install the necessary dependencies
5. Restart applications or your user session for the changes to take effect.

```
## 📜 License

This repository is licensed under the [MIT License](https://opensource.org/licenses/MIT). Feel free to use, modify, and distribute the configurations as per the terms of this license.

### License Details
- **MIT License:** Applies to all configurations and files in this repository, except for those explicitly mentioned below.
- **Apache License 2.0:** Specifically applies to the Neovim configuration files located in the `nvim` directory. Refer to the [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0.html) for details.

Please ensure compliance with both licenses when using and distributing this repository.

For more information, refer to the `LICENSE` file included in the repository root.
