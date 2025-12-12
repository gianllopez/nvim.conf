-- This file configures coding assistance tools. It includes automatic
-- closing of pairs (brackets, quotes) and intelligent commenting
-- capabilities powered by Treesitter.
-- by @gianllopez (2025)

return {
	-- Auto-close brackets, quotes, etc.
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = { modes = { command = true } },
	},

	-- Intelligent comments based on Treesitter
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
}
