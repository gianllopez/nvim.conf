-- This file configures the formatting engine. It ensures code is auto-formatted
-- on save using standard tools like Prettier and Ruff, managing dependencies
-- via Mason.
-- by @gianllopez (2025)

return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ensure_installed = {
						"prettier",
						"ruff",
						"stylua",
					},
				},
			},
		},
		opts = {
			format_on_save = true,
			formatters_by_ft = {
				astro = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				json = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				python = { "ruff_format" },
				scss = { "prettier" },
				svg = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				yaml = { "prettier" },
			},
		},
	},
}
