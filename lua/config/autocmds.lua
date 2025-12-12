-- This file defines event-driven automation (autocommands) for the
-- editor. It handles global behaviors like highlighting copied text and
-- specific LSP configurations, such as adjusting capabilities for the Ruff server.
-- by @gianllopez (2025)

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Create a unique group for your configuration to avoid duplications
local general = augroup("gianllopez", { clear = true })

-- [`python/lsp`]: disable hover capability from `ruff` (conflicts with pyright/basedpyright)
autocmd("LspAttach", {
	group = general,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == "ruff" then
			client.server_capabilities.hoverProvider = false
		end
	end,
})

-- [`gianllopez/neovim.conf`]: highlight text on yank
autocmd("TextYankPost", {
	group = general,
	callback = function()
		vim.hl.on_yank()
	end,
})
