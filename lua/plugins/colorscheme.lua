-- This file configures the active color scheme (theme) for Neovim. It uses
-- high priority to ensure the theme loads before other UI plugins to
-- prevent visual glitches during startup.
-- by @gianllopez (2025)

return {
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("kanagawa")
		end,
	},
}
