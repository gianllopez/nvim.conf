-- [`gianllopez/neovim.conf`]: leader definition
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [`gianllopez/neovim.conf`]: tabs and spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- [`gianllopez/neovim.conf`]: clipboard
vim.opt.clipboard = "unnamedplus"

-- [`gianllopez/neovim.conf`]: relative number
vim.opt.relativenumber = true

-- [`gianllopez/neovim.conf`]: wrap behavior
vim.opt.wrap = false

-- [`gianllopez/neovim.conf`]: confirm before quit on unsaved files
vim.opt.confirm = true

-- [`gianllopez/neovim.conf`]: adjust the delay to detect key sequence completion
vim.o.timeoutlen = 500

-- [`akinsho/bufferline.nvim`]: requirement for plugin usage
vim.opt.termguicolors = true
