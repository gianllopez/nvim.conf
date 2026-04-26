-- This module implements the audit plugin: an interactive UI
-- to set and review file status with persistent history.
-- by @gianllopez (2026)

local M = {}

local utils = require("custom.utils")

local Menu = require("nui.menu")
local Popup = require("nui.popup")

local ICONS = {
	pending = "⏳",
	review = "🔍",
	done = "✅",
}

function M.open()
	local menu = Menu({
		position = "50%",
		size = {
			width = 28,
			height = 3,
		},
		border = {
			style = "rounded",
			text = {
				top = " What's the file status? ",
				top_align = "center",
			},
		},
	}, {
		lines = {
			Menu.item(" " .. ICONS.pending .. " -> Pending", { id = "pending", icon = ICONS.pending }),
			Menu.item(" " .. ICONS.review .. " -> In review", { id = "review", icon = ICONS.review }),
			Menu.item(" " .. ICONS.done .. " -> Done", { id = "done", icon = ICONS.done }),
		},
		on_submit = function(item)
			utils.save(item.id)
			vim.notify(
				"Status set to `" .. item.id .. "` (" .. item.icon .. ")",
				vim.log.levels.INFO,
				{ title = "Audit" }
			)
		end,
	})

	menu:mount()
end

function M.history()
	local entry, file = utils.entry()

	if not entry or not entry.history or #entry.history == 0 then
		vim.notify("No history for this file", vim.log.levels.WARN, { title = "Audit" })
		return
	end

	local lines = vim.tbl_map(function(h)
		return string.format("  %s  %s  %s", h.at:gsub("T", " "):gsub("Z", ""), ICONS[h.status], h.status)
	end, entry.history)

	local popup = Popup({
		position = "50%",
		size = {
			width = 42,
			height = math.min(#lines, 10),
		},
		border = {
			style = "rounded",
			text = {
				top = "  " .. vim.fn.fnamemodify(file, ":t") .. " ",
				top_align = "center",
			},
		},
		buf_options = {
			modifiable = true,
		},
	})

	popup:mount()
	vim.api.nvim_set_current_win(popup.winid)

	vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, lines)
	vim.bo[popup.bufnr].modifiable = false

	popup:map("n", { "q", "<Esc>" }, function()
		popup:unmount()
	end)
end

function M.filter()
	local menu = Menu({
		position = "50%",
		size = {
			width = 28,
			height = 3,
		},
		border = {
			style = "rounded",
			text = {
				top = " Filter by status ",
				top_align = "center",
			},
		},
	}, {
		lines = {
			Menu.item(" " .. ICONS.pending .. " -> Pending", { id = "pending", icon = ICONS.pending }),
			Menu.item(" " .. ICONS.review .. " -> In review", { id = "review", icon = ICONS.review }),
			Menu.item(" " .. ICONS.done .. " -> Done", { id = "done", icon = ICONS.done }),
		},
		on_submit = function(item)
			local root = utils.root()
			local database = utils.read(utils.path(root))
			local files = {}

			for file, data in pairs(database) do
				if data.status == item.id then
					table.insert(files, file)
				end
			end

			if #files == 0 then
				vim.notify("No files with status `" .. item.id .. "`", vim.log.levels.WARN, { title = "Audit" })
				return
			end

			require("fzf-lua").fzf_exec(files, {
				prompt = item.icon .. "  ",
				cwd = root,
				actions = {
					["default"] = require("fzf-lua").actions.file_edit,
				},
			})
		end,
	})

	menu:mount()
end

return M
