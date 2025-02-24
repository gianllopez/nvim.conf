return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		opts = {
			filters = {
				dotfiles = true,
				custom = { "^%.venv%..*", "node_modules" },
				exclude = {
					-- environment
					"%.env$",
					"%.env%..*",
					-- git
					"%.gitignore",
					-- javascript, typescript
					"%.prettierrc%.yml",
					"%.eslintrc.js",
					-- docker
					"%.dockerignore",
				},
			},
			sort = { sorter = "filetype" },
			view = { adaptive_size = true },
			renderer = {
				indent_markers = { enable = true },
				icons = { git_placement = "after" },
			},
			update_focused_file = { enable = true },
			ui = { confirm = { default_yes = true } },
		},
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
	},
	{
		"ibhagwan/fzf-lua",
		opts = {
			winopts = {
				title_pos = "center",
			},
		},
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
	},
	{
		"stevearc/dressing.nvim",
		opts = {
			select = {
				backend = { "fzf_lua" },
				fzf_lua = {
					winopts = {
						width = 0.5,
						height = 0.5,
						preview = { hidden = "hidden" },
					},
				},
			},
		},
	},
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {
			win = {
				wo = {
					wrap = true,
				},
			},
		},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				char = { enabled = false },
			},
		},
	},
	{
		"smjonas/inc-rename.nvim",
		opts = {},
	},
	{
		"MagicDuck/grug-far.nvim",
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
}
