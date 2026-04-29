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

-- [`nvim-treesitter/nvim-treesitter`]: start `nvim-treesitter/nvim-treesitter` highlighting for any filetype
autocmd("FileType", {
	group = general,
	pattern = { "*" },
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

-- [`gianllopez/neovim.conf`]: highlight text on yank
autocmd("TextYankPost", {
	group = general,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- [`custom/audit`]: remove deleted files from audit registry
autocmd("BufDelete", {
	group = general,
	callback = function(ev)
		local bufname = vim.api.nvim_buf_get_name(ev.buf)

		if bufname == "" or vim.fn.filereadable(bufname) == 1 then
			return
		end

		local matches = vim.fs.find(".git", {
			upward = true,
			path = vim.fn.fnamemodify(bufname, ":h"),
		})

		local root = matches[1] and vim.fs.dirname(matches[1]) or vim.fn.getcwd()
		local rel = bufname:sub(#root + 2)

		if rel == "" then
			return
		end

		local utils = require("custom.audit.utils")
		local constants = require("custom.audit.constants")

		local path = utils.path(root)
		local database = utils.read(path)

		if database[rel] then
			local icon = constants.STATUSES[database[rel].status].icon

			database[rel] = nil

			utils.write(path, database)

			vim.notify("`" .. rel .. "` removed from audit (" .. icon .. ")", vim.log.levels.INFO, { title = "Audit" })
		end
	end,
})
