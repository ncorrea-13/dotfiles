# My personal linux's dotfiles

Welcome to my collection of dotfiles! Here you will find my personal configurations for essential Linux tools.

> **Note:** It is thought to use Wayland with Sway. There are also configs for i3 and i3blocks, but these are currently unmantained since I no longer use Xorg

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

    **Note**: Ensure that the `~/.config` directory exists before moving the directories.

4. Install the necessary dependencies
5. Restart applications or your user session for the changes to take effect.

## Screenshots

![[screenshots/Sway/3-Zellij.png]](https://github.com/ncorrea-13/dotfiles/blob/main/screenshots/Sway/3-Zellij.png)

![](https://github.com/ncorrea-13/dotfiles/blob/main/screenshots/Sway/4-Browsers.png)

## License

- **Configs:** [MIT License](https://opensource.org/licenses/MIT)
- **Lazyvim:** [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0.html)

Please ensure compliance with both licenses when using and distributing this repository.

For more information, refer to the [LICENSE](LICENSE) file included in the repository root.

*Mendoza, Argentina — Nicolás Correa ([ncorrea-13](https://github.com/ncorrea-13))*
