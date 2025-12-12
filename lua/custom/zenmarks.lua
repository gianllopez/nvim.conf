-- This module provides persistence for Nvim-Tree "marks" (bookmarks). It
-- saves the marked files to a local file in the current project directory.
-- REMEMBER: Add '.zenmarks.json' to your .gitignore file.
-- by @gianllopez (2025)

local M = {}

local api = require("nvim-tree.api")

local output = ".marks.json"

function M.save()
	local marks = api.marks.list()

	if not marks or #marks == 0 then
		vim.notify("There are no marks to save", vim.log.levels.WARN, {
			title = "zenmarks persistence",
			icon = "⚠️",
		})
		return
	end

	local path = vim.fn.getcwd() .. "/" .. output
	local file = io.open(path, "w")

	if file then
		local paths = {}

		for _, node in ipairs(marks) do
			table.insert(paths, node.absolute_path)
		end

		local json = vim.json.encode(paths)

		file:write(json)
		file:close()

		vim.notify("Marks saved to `" .. output .. "`", vim.log.levels.INFO, {
			title = "zenmarks persistence",
			icon = "✅",
		})
	end
end

function M.load()
	local path = vim.fn.getcwd() .. "/" .. output
	local file = io.open(path, "r")

	if not file then
		return
	end

	local content = file:read("*a")
	file:close()

	local ok, paths = pcall(vim.json.decode, content)

	if not ok then
		vim.notify("Error parsing `" .. output .. "`", vim.log.levels.ERROR, {
			title = "zenmarks persistence",
			icon = "❌",
		})
		return
	end

	for _, p in ipairs(paths) do
		api.tree.find_file({ buf = p, open = true, focus = true })
		local node = api.tree.get_node_under_cursor()

		if node then
			api.marks.toggle(node)
		end
	end

	vim.notify("Marks loaded from `" .. output .. "`", vim.log.levels.INFO, {
		title = "zenmarks persistence",
		icon = "🔖",
	})
end

return M
