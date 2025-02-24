return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		opts = {
			options = {
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						separator = true,
					},
				},
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		opts = {},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			presets = { inc_rename = true },
			routes = {
				{
					filter = {
						any = {
							-- [`gianllopez/neovim.conf`]
							{ event = "msg_show", find = "written" },
							-- [`nvim-tree/nvim-tree.lua`]
							{ event = "notify", find = "was properly removed" },
							{ event = "notify", find = "was properly created" },
							{ event = "notify", find = "added to clipboard" },
							{ event = "notify", find = "->" },
							-- [`neovim/nvim-lspconfig`]
							{ event = "notify", find = "No information available" },
						},
					},
					opts = { skip = true },
				},
			},
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = { enabled = false },
		},
	},
}
