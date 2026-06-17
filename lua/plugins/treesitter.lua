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
					ensure_installed = { "tree-sitter-cli" },
				},
			},
		},
		opts = {
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"astro",
				"bash",
				"css",
				"dockerfile",
				"html",
				"htmldjango",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"scss",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
		},
	},

	-- Auto close tags
	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},
}
