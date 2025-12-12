-- This file configures the User Interface (UI) components: status line,
-- buffer bar, notifications, and indentation guides. It aims to provide a
-- clean and modern visual experience.
-- by @gianllopez (2025)

return {
	-- Show open buffers as tabs at the top
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
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

	-- The status line at the bottom
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},

	-- Replaces the UI for messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
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

	-- Adds indentation guides to all lines
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = { enabled = false },
		},
	},
}
