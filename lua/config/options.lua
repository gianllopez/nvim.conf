-- This file sets the global Neovim options (vim.opt/vim.g). It configures
-- the editor's behavior, UI appearance, indentation, and key leader settings.
-- by @gianllopez (2025)

-- [`gianllopez/neovim.conf`]: leader definition
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [`gianllopez/neovim.conf`]: tabs and spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- [`gianllopez/neovim.conf`]: clipboard
vim.opt.clipboard = "unnamedplus"

-- [`gianllopez/neovim.conf`]: line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- [`gianllopez/neovim.conf`]: wrap behavior
vim.opt.wrap = false

-- [`gianllopez/neovim.conf`]: confirm before quit on unsaved files
vim.opt.confirm = true

-- [`gianllopez/neovim.conf`]: adjust the delay to detect key sequence completion
vim.o.timeoutlen = 500

-- [`gianllopez/neovim.conf`]: search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

-- [`gianllopez/neovim.conf`]: ui improvements
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.scrolloff = 8

-- [`gianllopez/neovim.conf`]: split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- [`gianllopez/neovim.conf`]: system
vim.opt.undofile = true
vim.opt.updatetime = 250

-- [`akinsho/bufferline.nvim`]: requirement for plugin usage
vim.opt.termguicolors = true
