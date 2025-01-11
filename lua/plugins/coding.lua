return {
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = { modes = { command = true } },
	},
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
}
