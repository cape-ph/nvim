# CAPE's Neovim Configuration

A Neovim configuration based on the [AstroNvim](https://astronvim.com/) distribution for development within the CAPE organization and to set up all of the languages and common tooling used.

## ⚡ Requirements

- [Neovim v0.9.5+](https://neovim.io/)
- [Git v2.19.0+](https://git-scm.com/)
- A C compiler in your path and `libstdc++` installed (Ex. `gcc`, `clang`, `zig`, [Windows users please read this!](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support))
- [A Nerd Font](https://www.nerdfonts.com/)
- [A Terminal with true color support](https://github.com/termstandard/colors?tab=readme-ov-file#truecolor-support-in-output-devices)<sup>[[2]](#2)</sup>
- Requirements to install tools (must be in `$PATH`):
  - `curl` - Mason in general
  - `pip` - `isort`, `black`, `pyright`, `debugpy`
  - `npm` - `prettier`, `json-language-server`, `yaml-language-server`
  - `go` - `regols`
  - `opa` (_optional_) - `opa_check`

> [!NOTE] > <sup id="2">[2]</sup> Note when using default theme: For MacOS, the default terminal does not have true color support. You will need to use [iTerm2](https://iterm2.com/), [Kitty](https://sw.kovidgoyal.net/kitty/), [WezTerm](https://wezfurlong.org/wezterm/), or another [terminal emulator](https://gist.github.com/XVilka/8346728#terminal-emulators) that has true color support.

## 🛠️ Usage (Unix/Mac Instructions)

1. Clone the repository to the folder `~/.config/cape`

```sh
git clone https://github.com/cape-ph/nvim.git ~/.config/cape
```

2. Run the configuration using the `NVIM_APPNAME` environment variable

```sh
NVIM_APPNAME=cape nvim
```

> [!TIP]
> You can make this default by exporting `NVIM_APPNAME=cape` in a terminal session or in your shell configuration
>
> ```sh
> export NVIM_APPNAME=cape
> nvim
> ```
