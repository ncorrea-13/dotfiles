# My personal linux's dotfiles

Welcome to my collection of dotfiles! Here you will find my personal configurations for essential Linux tools.

## Contents

- **Sway** - Window manager configuration for Wayland.
- **Waybar** - Status bar configuration for Wayland.
- **Btop++** - Resource monitor configuration.
- **Cava** - Audio visualizer configuration.
- **Dunst** - Notification service configuration.
- **Fastfetch** - System information tool configuration.
- **Neovim** - Custom configuration based on LazyVim.
- **Picom** - Window compositor configuration.
- **Posting** - API Rest tool.
- **Rofi** - Application launcher configuration.
- **Vifm** - Terminal file manager configuration.
- **WezTerm** - Terminal emulator configuration.
- **Zellij** - Terminal multiplexer configuration.

There are also configs for i3 and i3blocks, but these are currently unmantained since I no longer use Xorg

## Installation

To install these configurations on your system, follow these steps:

1. Clone the repository into your home directory:

    ```bash
    git clone https://github.com/ncorrea-13/dotfiles.git ~/dotfiles
    ```

2. Navigate to the repository directory:

    ```bash
    cd ~/dotfiles
    ```

3. Move the configuration files in the repository to your `~/.config` directory:

    ```bash
    mv .config/* ~/.config/
    ```

    You could also move only the configuration you want to import

    ```bash
    mv .config/nvim ~/.config
    ```

    **Note**: Ensure that the `~/.config` directory exists before creating symbolic links.

4. Install the necessary dependencies
5. Restart applications or your user session for the changes to take effect.

## License

This repository is licensed under the [MIT License](https://opensource.org/licenses/MIT). Feel free to use, modify, and distribute the configurations as per the terms of this license.

### License Details

- **MIT License:** Applies to all configurations and files in this repository, except for those explicitly mentioned below.
- **Apache License 2.0:** Specifically applies to the Neovim configuration files located in the `nvim` directory. Refer to the [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0.html) for details.

Please ensure compliance with both licenses when using and distributing this repository.

For more information, refer to the `LICENSE` file included in the repository root.
