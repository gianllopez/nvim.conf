local M = {}

local api = require("nvim-tree.api")

local output_folder = vim.fn.stdpath("data") .. "/zenmarks"
local output_hash = vim.fn.sha256(vim.fn.getcwd())
local output_path = string.format("%s/%s.json", output_folder, output_hash)

vim.fn.mkdir(output_folder, "p")

function M.save()
	local marks = api.marks.list()

	if marks == nil then
		vim.notify("There is no marks to save", vim.log.levels.WARN, {
			title = "`zenmarks` persistence",
			icon = "⚠️",
		})
		return
	end

	local output = io.open(output_path, "w")

	if output then
		local paths = {}

		for _, node in ipairs(marks) do
			table.insert(paths, node.absolute_path)
		end

		local json = vim.fn.json_encode(paths)

		output:write(json)
		output:close()

		vim.notify("Marks were saved successfully", vim.log.levels.INFO, {
			title = "`zenmarks` persistence",
			icon = "✅",
		})
	end
end

function M.load()
	local output = io.open(output_path, "r")

	if not output then
		vim.notify("There is an error with marks file", vim.log.levels.ERROR, {
			title = "`zenmarks` persistence",
			icon = "❌",
		})
		return
	end

	local marks = output:read("*a")

	output:close()
	local loaded, paths = pcall(vim.fn.json_decode, marks)

	if not loaded then
		vim.notify("There is an error loading the marks", vim.log.levels.ERROR, {
			title = "`zenmarks` persistence",
			icon = "❌",
		})
		return
	end

	for _, path in ipairs(paths) do
		api.tree.find_file({ buf = path, open = true, focus = true })
		local node = api.tree.get_node_under_cursor()
		if node then
			api.marks.toggle(node)
		end
	end
end

return M
