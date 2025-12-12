-- This file bundles editor utilities: file explorer, fuzzy finder,
-- diagnostics viewer, key binding manager, and search tools. It focuses
-- on navigation and code manipulation speed.
-- by @gianllopez (2025)

return {
	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			filters = {
				dotfiles = true,
				custom = { "^%.venv%..*", "node_modules" },
				exclude = {
					"%.env$",
					"%.env%..*",
					"%.gitignore",
					"%.prettierrc%.yml",
					"%.eslintrc.js",
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
	},

	-- Fuzzy finder (fastest option using C binary)
	{
		"ibhagwan/fzf-lua",
		cmd = "FzfLua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			winopts = { title_pos = "center" },
		},
	},

	-- Improves UI for vim.ui.select and input
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
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

	-- Pretty diagnostics list
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {
			win = { wo = { wrap = true } },
		},
	},

	-- Lightning fast navigation/jumping
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = { char = { enabled = false } },
		},
	},

	-- Incremental renaming with preview
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		opts = {},
	},

	-- Search and replace engine
	{
		"MagicDuck/grug-far.nvim",
		cmd = "GrugFar",
		opts = {},
	},

	-- Comments highlights
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	-- Keymaps manager
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts_extend = { "spec" },
		opts = {
			preset = "helix",
			spec = {
				{
					mode = { "n", "v" },
					-- Groups
					{ "<leader>b", group = "buffer" },
					{ "<leader>c", group = "code/rename" },
					{ "<leader>f", group = "file/find" },
					{ "<leader>n", group = "notifications" },
					{ "<leader>o", group = "organize" },
					{ "<leader>s", group = "split/search" },
					{ "<leader>t", group = "trouble" },

					-- Navigation
					{ "H", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
					{ "L", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
					{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
					{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },

					-- Buffer Actions
					{ "b", group = "buffer actions" },
					{ "bcl", "<cmd>BufferLineCloseLeft<cr>", desc = "Close Left" },
					{ "bcr", "<cmd>BufferLineCloseRight<cr>", desc = "Close Right" },
					{ "bco", "<cmd>BufferLineCloseOthers<cr>", desc = "Close Others" },
					{ "bcp", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle Pin" },
					{ "bp", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },

					-- Flash & Windows
					{ "s", group = "flash/window" },
					{
						"s",
						function()
							require("flash").jump()
						end,
						desc = "Flash Jump",
					},
					{
						"S",
						function()
							require("flash").treesitter()
						end,
						desc = "Flash Treesitter",
					},
					{ "sj", "<C-w>j", desc = "Window Down" },
					{ "sk", "<C-w>k", desc = "Window Up" },
					{ "sl", "<C-w>l", desc = "Window Right" },

					-- Explorer Mappings
					{ "fe", group = "explorer" },
					{ "fe", "<cmd>NvimTreeFocus<cr>", desc = "Focus Tree" },
					{
						"fesm",
						function()
							require("custom.zenmarks").save()
						end,
						desc = "Save Marks",
					},
					{
						"felm",
						function()
							require("custom.zenmarks").load()
						end,
						desc = "Load Marks",
					},

					-- Editing
					{ "ri", group = "replace" },
					{ "riw", "viwP", desc = "Replace Inner Word" },
					{
						"ri",
						function()
							local char = vim.fn.getcharstr()
							vim.cmd("normal! di" .. char .. '"+P')
						end,
						desc = "Replace Inside Char",
						icon = "",
					},
					{ "cd", "yyPj", desc = "Clone Line Down" },
					{ "ch", "<cmd>noh<cr>", desc = "Clear Highlights" },
					{ ";", ":", desc = "Command Mode", nowait = true },

					-- LSP Base
					{
						"gd",
						function()
							vim.lsp.buf.definition()
						end,
						desc = "Goto Definition",
					},

					-- Leader Mappings
					{ "<leader>bcc", "<cmd>bdelete<cr>", desc = "Close Buffer" },
					{
						"<leader>ca",
						function()
							vim.lsp.buf.code_action()
						end,
						desc = "Code Action",
					},
					{
						"<leader>cr",
						function()
							return ":IncRename " .. vim.fn.expand("<cword>")
						end,
						expr = true,
						desc = "Rename (IncRename)",
					},
					{ "<leader>fe", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Explorer" },
					{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
					{ "<leader>fg", "<cmd>FzfLua live_grep_native<cr>", desc = "Live Grep" },
					{ "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "Resume Fzf" },
					{
						"<leader>oi",
						function()
							vim.lsp.buf.code_action({
								apply = true,
								context = { only = { "source.organizeImports" }, diagnostics = {} },
							})
						end,
						desc = "Organize Imports",
					},
					{
						"<leader>%",
						function()
							return ":%s/" .. vim.fn.expand("<cword>") .. "//gc"
						end,
						expr = true,
						desc = "Replace Word (Global)",
					},
					{
						"<leader>sr",
						function()
							require("grug-far").open()
						end,
						desc = "Search & Replace (Grug)",
					},
					{ "<leader>ss", "<cmd>split<cr>", desc = "Split Horizontal" },
					{ "<leader>sv", "<cmd>vsplit<cr>", desc = "Split Vertical" },
					{ "<leader>sh", "<C-w>h", desc = "Window Left" },
					{ "<leader>tro", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
					{ "<leader>nd", "<cmd>Noice dismiss<cr>", desc = "Dismiss Notifications" },
					{ "<leader>l", "<cmd>Lazy<cr>", desc = "Lazy", icon = "💤" },
				},
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Keymaps (which-key)",
			},
		},
	},
}
