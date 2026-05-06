-- This module implements the audit plugin: an interactive UI
-- to set and review file status with persistent history.
-- by @gianllopez (2026)

local M = {}

local utils = require("custom.audit.utils")
local constants = require("custom.audit.constants")

local Menu = require("nui.menu")
local Popup = require("nui.popup")

local function bulk_set(files, status)
	local root = utils.root()
	local path = utils.path(root)

	local database = utils.read(path)
	local now = os.date("!%Y-%m-%dT%H:%M:%SZ")

	local count = 0

	for _, file in ipairs(files) do
		local entry = database[file] or { history = {} }

		if entry.status ~= status then
			table.insert(entry.history, { status = status, at = now })

			entry.status = status

			database[file] = entry

			count = count + 1
		end
	end

	if count > 0 then
		utils.write(path, database)
	end

	return count
end

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
			Menu.item(" " .. constants.STATUSES.pending.icon .. " -> Pending", {
				id = "pending",
				icon = constants.STATUSES.pending.icon,
			}),
			Menu.item(" " .. constants.STATUSES.review.icon .. " -> In review", {
				id = "review",
				icon = constants.STATUSES.review.icon,
			}),
			Menu.item(" " .. constants.STATUSES.done.icon .. " -> Done", {
				id = "done",
				icon = constants.STATUSES.done.icon,
			}),
		},
		on_submit = function(item)
			if not utils.save(item.id) then
				vim.notify(
					"Status already set to `" .. item.id .. "` (" .. item.icon .. ")",
					vim.log.levels.WARN,
					{ title = "Audit" }
				)
				return
			end

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
		return string.format(
			"  %s  %s  %s",
			h.at:gsub("T", " "):gsub("Z", ""),
			constants.STATUSES[h.status].icon,
			h.status
		)
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
			Menu.item(" " .. constants.STATUSES.pending.icon .. " -> Pending", {
				id = "pending",
				icon = constants.STATUSES.pending.icon,
			}),
			Menu.item(" " .. constants.STATUSES.review.icon .. " -> In review", {
				id = "review",
				icon = constants.STATUSES.review.icon,
			}),
			Menu.item(" " .. constants.STATUSES.done.icon .. " -> Done", {
				id = "done",
				icon = constants.STATUSES.done.icon,
			}),
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

			table.sort(files)

			if #files == 0 then
				vim.notify("No files with status `" .. item.id .. "`", vim.log.levels.WARN, { title = "Audit" })
				return
			end

			require("fzf-lua").fzf_exec(files, {
				prompt = item.icon .. "  ",
				actions = {
					["default"] = function(selected)
						vim.cmd("edit " .. vim.fn.fnameescape(root .. "/" .. selected[1]))
					end,
				},
			})
		end,
	})

	menu:mount()
end

function M.bulk_set_as_pending()
	if vim.fn.confirm("Mark untracked files as `pending`?", "&Yes\n&No", 2) ~= 1 then
		return
	end

	local root = utils.root()
	local process = io.popen("git -C " .. vim.fn.shellescape(root) .. " ls-files")

	if not process then
		vim.notify("Could not list project files, is this a git repository?", vim.log.levels.ERROR, { title = "Audit" })
		return
	end

	local path = utils.path(root)
	local database = utils.read(path)

	local files = {}

	for line in process:lines() do
		if line ~= "" and not database[line] then
			table.insert(files, line)
		end
	end

	process:close()

	local count = bulk_set(files, "pending")

	vim.notify(
		count .. " file(s) marked as `pending` (" .. constants.STATUSES.pending.icon .. ")",
		vim.log.levels.INFO,
		{ title = "Audit" }
	)
end

function M.bulk_set_last_commit_as_review()
	if vim.fn.confirm("Mark last commit files as review?", "&Yes\n&No", 2) ~= 1 then
		return
	end

	local root = utils.root()
	local process = io.popen("git -C " .. vim.fn.shellescape(root) .. " diff-tree --no-commit-id -r --name-only HEAD")

	if not process then
		vim.notify(
			"Could not read last commit files, is this a git repository?",
			vim.log.levels.ERROR,
			{ title = "Audit" }
		)
		return
	end

	local files = {}

	for line in process:lines() do
		if line ~= "" then
			table.insert(files, line)
		end
	end

	process:close()

	local count = bulk_set(files, "review")

	vim.notify(
		count .. " file(s) marked as `review` (" .. constants.STATUSES.review.icon .. ")",
		vim.log.levels.INFO,
		{ title = "Audit" }
	)
end

function M.clear_file_history()
	local root = utils.root()
	local file = utils.relative(root)

	if file == "" then
		vim.notify("No file open", vim.log.levels.WARN, { title = "Audit" })
		return
	end

	if vim.fn.confirm("Clear audit history for `" .. file .. "`?", "&Yes\n&No", 2) ~= 1 then
		return
	end

	local entry = utils.entry()
	local icon = entry and constants.STATUSES[entry.status].icon

	if utils.remove(root) then
		vim.notify(
			"Audit history cleared for `" .. file .. "` (" .. icon .. ")",
			vim.log.levels.INFO,
			{ title = "Audit" }
		)
	else
		vim.notify("No audit entry found for `" .. file .. "`", vim.log.levels.WARN, { title = "Audit" })
	end
end

function M.clean_orphans()
	local root = utils.root()
	local count = utils.clean(root)

	if count == 0 then
		vim.notify("No orphaned entries found", vim.log.levels.INFO, { title = "Audit" })
	else
		vim.notify(count .. " orphaned entry(s) removed from audit", vim.log.levels.INFO, { title = "Audit" })
	end
end

function M.status()
	local entry = utils.entry()

	if not entry or not entry.status then
		return ""
	end

	return constants.STATUSES[entry.status].icon .. " " .. entry.status
end

return M
