return {
	{
		"stevearc/conform.nvim",
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ensure_installed = {
						-- lua
						"stylua",
						-- python
						"ruff",
						-- typescript
						"prettierd",
					},
				},
			},
		},
		opts = {
			format_on_save = true,
			formatters = {
				prettier = { command = "node_modules/prettier/bin/prettier.cjs" },
			},
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
				json = { "prettier" },
				svg = { "prettier" },
			},
		},
	},
}
