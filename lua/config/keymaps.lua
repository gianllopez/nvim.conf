local map = vim.keymap.set

-- [`gianllopez/neovim.conf`]: `discipline` setup
require("custom.discipline").ninja()

-- [`gianllopez/neovim.conf`]: disable left arrow navigation
map({ "n", "i", "v" }, "<Left>", "<Nop>")

-- [`gianllopez/neovim.conf`]: disable down arrow navigation
map({ "n", "i", "v" }, "<Down>", "<Nop>")

-- [`gianllopez/neovim.conf`]: disable right arrow navigation
map({ "n", "i", "v" }, "<Right>", "<Nop>")

-- [`gianllopez/neovim.conf`]: disable up arrow navigation
map({ "n", "i", "v" }, "<Up>", "<Nop>")

-- [`gianllopez/neovim.conf`]: enter on interactive mode
map("n", ";", ":", { noremap = true, nowait = true })

-- [`gianllopez/neovim.conf`]: replace in word
map("n", "riw", "viwP", { noremap = true, nowait = true })

-- [`gianllopez/neovim.conf`]: replace inside
map("n", "ri", function()
	local char = vim.fn.getcharstr()
	vim.cmd("normal! di" .. char .. '"+P')
end, { noremap = true, nowait = true })

-- [`gianllopez/neovim.conf`]: split window horizontally
map("n", "<leader>ss", "<Cmd>split<CR>", { noremap = true, nowait = true })

-- [`gianllopez/neovim.conf`]: split window vertically
map("n", "<leader>sv", "<Cmd>vsplit<CR>", { noremap = true, nowait = true })

-- [`gianllopez/neovim.conf`]: move the cursor to left-split windows
map("n", "<leader>sh", "<C-w>h", { noremap = true, nowait = true })

-- [`gianllopez/neovim.conf`]: move the cursor to bottom-split windows
map("n", "sj", "<C-w>j", { noremap = true, nowait = true })

-- [`gianllopez/neovim.conf`]: move the cursor to top-split windows
map("n", "sk", "<C-w>k", { noremap = true, nowait = true })

-- [`gianllopez/neovim.conf`]: move the cursor to right-split windows
map("n", "sl", "<C-w>l", { noremap = true, nowait = true })

-- [`gianllopez/neovim.conf`]: remove search highlights
map("n", "ch", "<Cmd>noh<CR>", { noremap = true, nowait = true })

-- [`gianllopez/neovim.conf`]: clone current line down
map("n", "cd", "yyPj", { noremap = true, nowait = true })

-- [`gianllopez/neovim.conf`]: close current buffer
map("n", "<leader>bcc", "<Cmd>bdelete<CR>", { noremap = true, nowait = true })

-- [`gianllopez/neovim.conf`]:
map("n", "<leader>%", function()
	return ":%s/" .. vim.fn.expand("<cword>") .. "//gc"
end, { noremap = true, expr = true })

-- [`neovim/nvim-lspconfig`]: organize current buffer imports
map("n", "<leader>oi", function()
	vim.lsp.buf.code_action({
		apply = true,
		context = {
			only = { "source.organizeImports" },
			diagnostics = {},
		},
	})
end, { noremap = true, nowait = true })

-- [`neovim/nvim-lspconfig`]: go to definition
map("n", "gd", vim.lsp.buf.definition, { noremap = true, nowait = true })

-- [`neovim/nvim-lspconfig`]: execute code actions
map("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, nowait = true })

-- [`akinsho/bufferline`]: move to previous buffer
map("n", "H", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true, nowait = true })

-- [`akinsho/bufferline`]: move to next buffer
map("n", "L", "<Cmd>BufferLineCycleNext<CR>", { noremap = true, nowait = true })

-- [`akinsho/bufferline`]: allow buffer pick by letter
map("n", "bp", "<Cmd>BufferLinePick<CR>", { noremap = true, nowait = true })

-- [`akinsho/bufferline`]: close buffers at left
map("n", "bcl", "<Cmd>BufferLineCloseLeft<CR>", { noremap = true, nowait = true })

-- [`akinsho/bufferline`]: close buffers at right
map("n", "bcr", "<Cmd>BufferLineCloseRight<CR>", { noremap = true, nowait = true })

-- [`akinsho/bufferline`]: close others buffers
map("n", "bco", "<Cmd>BufferLineCloseOthers<CR>", { noremap = true, nowait = true })

-- [`akinsho/bufferline`]: toggle pin on the current buffer
map("n", "bcp", "<Cmd>BufferLineTogglePin<CR>", { noremap = true, nowait = true })

-- [`folke/noice.nvim`]: dismiss all notifications
map("n", "<leader>nd", "<Cmd>Noice dismiss<CR>", { noremap = true, nowait = true })

-- [`nvim-tree/nvim-tree.lua`]: toggle the file explorer
map("n", "<leader>fe", "<Cmd>NvimTreeToggle<CR>", { noremap = true, nowait = true })

-- [`nvim-tree/nvim-tree.lua`]: focus the file explorer
map("n", "fe", "<Cmd>NvimTreeFocus<CR>", { noremap = true })

-- [`ibhagwan/fzf-lua`]: find files
map("n", "<leader>ff", "<Cmd>FzfLua files<CR>", { noremap = true, nowait = true })

-- [`ibhagwan/fzf-lua`]: execute a live grep
map("n", "<leader>fg", "<Cmd>FzfLua live_grep_native<CR>", { noremap = true, nowait = true })

-- [`ibhagwan/fzf-lua`]: resume last command
map("n", "<leader>fr", "<Cmd>FzfLua resume<CR>", { noremap = true, nowait = true })

-- [`folke/flash.nvim`]: run in current buffer
map("n", "s", function()
	require("flash").jump()
end, { noremap = true })

-- [`folke/flash.nvim`]: run in current buffer using treesitter
map("n", "S", function()
	require("flash").treesitter()
end, { noremap = true })

-- [`folke/trouble.nvim`]: open the picker
map("n", "<leader>tro", "<Cmd>Trouble<CR>", { noremap = true, nowait = true })

-- [`smjonas/inc-rename.nvim`]: execute the renaming feature
map("n", "<leader>cr", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { noremap = true, expr = true })

-- [`MagicDuck/grug-far.nvim`]: open the search and replace window
map("n", "<leader>sr", function()
	require("grug-far").open()
end, { noremap = true, nowait = true })

-- [`lazy.nvim`]: open `Lazy` tool
map("n", "<leader>l", "<Cmd>Lazy<CR>", { noremap = true, nowait = true })
