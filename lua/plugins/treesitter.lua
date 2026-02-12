-- This file configures Treesitter, the parsing engine that provides improved
-- syntax highlighting, indentation, and code structural understanding. It
-- also includes a plugin to auto-close HTML/JSX tags.
-- by @gianllopez (2025)

return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ensure_installed = {
						"tree-sitter-cli",
					},
				},
			},
		},
		opts = {
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"vim",
				"vimdoc",
				"lua",
				"luadoc",
				"javascript",
				"typescript",
				"tsx",
				"html",
				"htmldjango",
				"css",
				"scss",
				"json",
				"python",
				"dockerfile",
				"bash",
				"markdown",
				"markdown_inline",
				"yaml",
				"toml",
			},
		},
	},

	-- Auto close tags
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
	},
}
