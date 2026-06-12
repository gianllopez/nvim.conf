# `neovim.conf`

A personal and minimal _Neovim_ setup for software development, built on top of [`lazy.nvim`](https://github.com/folke/lazy.nvim).

---

## Requirements

| Dependency                                                                               | Purpose                     |
| ---------------------------------------------------------------------------------------- | --------------------------- |
| [Neovim](https://neovim.io/) >= 0.10                                                     | Editor                      |
| [git](https://git-scm.com/)                                                              | Plugin manager bootstrap    |
| [fzf](https://github.com/junegunn/fzf), [ripgrep](https://github.com/BurntSushi/ripgrep) | Fuzzy finding and live grep |
| C compiler                                                                               | Tree-sitter parsers         |
| [Nerd Font](https://www.nerdfonts.com/)                                                  | Icons                       |

## Installation

```bash
$ git clone https://github.com/gianllopez/neovim.conf ~/.config/nvim
```

Open `nvim` and `lazy.nvim` will bootstrap itself and install every plugin automatically.

## Structure

```
.
├── init.lua
└── lua
    ├── config
    │   ├── options.lua
    │   ├── autocmds.lua
    │   └── lazy.lua
    ├── plugins
    │   ├── colorscheme.lua
    │   ├── coding.lua
    │   ├── editor.lua
    │   ├── formatting.lua
    │   ├── lsp.lua
    │   ├── treesitter.lua
    │   └── ui.lua
    └── custom
        ├── audit/
        └── discipline.lua
```

## Plugins

| Group       | About                                                         | Plugins                                                                                                                                                                                                                                                                                                                                                                                            |
| ----------- | ------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Colorscheme | Editor theme and highlight groups.                            | [`catppuccin/nvim`](https://github.com/catppuccin/nvim)                                                                                                                                                                                                                                                                                                                                            |
| LSP         | Language server installation, setup, and code intelligence.   | [`nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig), [`mason.nvim`](https://github.com/williamboman/mason.nvim)                                                                                                                                                                                                                                                                           |
| Completion  | Autocompletion and snippets while typing.                     | [`blink.cmp`](https://github.com/saghen/blink.cmp)                                                                                                                                                                                                                                                                                                                                                 |
| Syntax      | Incremental parsing for highlighting and structural editing.  | [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter), [`nvim-ts-autotag`](https://github.com/windwp/nvim-ts-autotag), [`ts-comments.nvim`](https://github.com/folke/ts-comments.nvim)                                                                                                                                                                                           |
| Formatting  | Code formatting on demand and on save.                        | [`conform.nvim`](https://github.com/stevearc/conform.nvim)                                                                                                                                                                                                                                                                                                                                         |
| Navigation  | Moving across files, buffers, and the project tree.           | [`fzf-lua`](https://github.com/ibhagwan/fzf-lua), [`nvim-tree.lua`](https://github.com/nvim-tree/nvim-tree.lua), [`flash.nvim`](https://github.com/folke/flash.nvim)                                                                                                                                                                                                                               |
| Editing     | Text manipulation: pairs, project-wide replace, and renaming. | [`mini.pairs`](https://github.com/echasnovski/mini.pairs), [`grug-far.nvim`](https://github.com/MagicDuck/grug-far.nvim), [`inc-rename.nvim`](https://github.com/smjonas/inc-rename.nvim)                                                                                                                                                                                                          |
| Diagnostics | Browsing errors, warnings, and TODO comments.                 | [`trouble.nvim`](https://github.com/folke/trouble.nvim), [`todo-comments.nvim`](https://github.com/folke/todo-comments.nvim)                                                                                                                                                                                                                                                                       |
| UI          | Statusline, bufferline, popups, and general interface polish. | [`lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim), [`bufferline.nvim`](https://github.com/akinsho/bufferline.nvim), [`noice.nvim`](https://github.com/folke/noice.nvim), [`which-key.nvim`](https://github.com/folke/which-key.nvim), [`dressing.nvim`](https://github.com/stevearc/dressing.nvim), [`indent-blankline.nvim`](https://github.com/lukas-reineke/indent-blankline.nvim) |

## Custom modules

| Module              | About                                                                                                                                                               |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `custom/audit`      | Interactive UI to set and review per-file status with persistent history per project. Includes bulk actions, cleanup of deleted files, and a `lualine` integration. |
| `custom/discipline` | Warns when navigation keys (`h`, `j`, `k`, `l`, `w`, `b`) are spammed excessively, encouraging more efficient movement commands.                                    |
