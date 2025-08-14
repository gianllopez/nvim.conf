return {
	{
		"neovim/nvim-lspconfig",
		event = "FileType",
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ensure_installed = {
						-- lua
						"lua-language-server",
						-- python
						"pyright",
						-- typescript
						"vtsls",
						-- typescript, javascript
						"eslint-lsp",
						-- tailwindcss
						"tailwindcss-language-server",
						-- sass
						"some-sass-language-server",
					},
				},
			},
			{
				"saghen/blink.cmp",
				version = "v0.*",
				opts = {
					keymap = { preset = "super-tab" },
				},
			},
		},
		opts = {
			servers = {
				-- lua
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				},
				-- python
				ruff = {},
				pyright = {
					settings = {
						pyright = {
							-- using `ruff` for organize imports
							disableOrganizeImports = true,
						},
						python = {
							analysis = {
								-- ignore all files for analysis to use `ruff` for linting
								ignore = { "*" },
							},
						},
					},
				},
				-- typescript
				vtsls = {},
				-- typescript, javascript
				eslint = {},
				-- tailwindcss
				tailwindcss = {},
				-- sass
				somesass_ls = {},
			},
		},
		config = function(_, opts)
			for server, config in pairs(opts.servers) do
				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
				vim.lsp.enable(server, config)
			end
		end,
	},
}
