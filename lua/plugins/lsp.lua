-- This file configures the Language Server Protocol (LSP). It manages the
-- downloading of language servers via Mason, connects them to Neovim via
-- lspconfig, and integrates the Blink completion engine.
-- by @gianllopez (2025)

return {
	{
		"neovim/nvim-lspconfig",
		event = "FileType",
		dependencies = {
			-- Package manager for LSP servers, DAP servers, linters, and formatters
			{
				"williamboman/mason.nvim",
				opts = {
					ensure_installed = {
						"lua-language-server",
						"pyright", -- Type checking for Python
						"ruff", -- Linter/Formatter for Python
						"vtsls", -- Advanced TypeScript wrapper
						"eslint-lsp",
						"tailwindcss-language-server",
						"somesass-language-server",
					},
				},
			},
			-- Ultra-fast completion engine based on Rust
			{
				"saghen/blink.cmp",
				version = "v0.*",
				opts = {
					keymap = { preset = "super-tab" },
					sources = {
						default = { "lsp", "path", "snippets", "buffer" },
					},
				},
			},
		},
		opts = {
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
						},
					},
				},
				ruff = {},
				pyright = {
					settings = {
						pyright = {
							disableOrganizeImports = true,
						},
					},
				},
				vtsls = {},
				eslint = {},
				tailwindcss = {},
				somesass_ls = {},
			},
		},
		config = function(_, opts)
			local blink = require("blink.cmp")
			for server, config in pairs(opts.servers) do
				config.capabilities = blink.get_lsp_capabilities(config.capabilities)
				vim.lsp.config[server] = config
				vim.lsp.enable(server)
			end
		end,
	},
}
