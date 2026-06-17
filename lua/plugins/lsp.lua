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
						"astro-language-server",
						"eslint-lsp",
						"lua-language-server",
						"pyright",
						"ruff",
						"somesass-language-server",
						"tailwindcss-language-server",
						"vtsls",
					},
				},
			},
			-- Ultra-fast completion engine based on Rust
			{
				"saghen/blink.cmp",
				version = "1.*",
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
				astro = {
					init_options = {
						typescript = {
							tsdk = vim.fn.stdpath("data")
								.. "/mason/packages/astro-language-server/node_modules/typescript/lib",
						},
					},
				},
				eslint = {},
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
						},
					},
				},
				pyright = {
					settings = {
						pyright = {
							disableOrganizeImports = true,
						},
					},
				},
				ruff = {},
				somesass_ls = {},
				tailwindcss = {},
				vtsls = {},
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
