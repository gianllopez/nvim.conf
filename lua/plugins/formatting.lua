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
						"stylua",
						"ruff",
						"prettier",
					},
				},
			},
		},
		opts = {
			format_on_save = true,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				javascriptreact = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				svg = { "prettier" },
			},
		},
	},
}
