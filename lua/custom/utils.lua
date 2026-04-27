-- This module provides shared utilities for custom plugins: project root
-- detection, relative path resolution, and JSON persistence helpers.
-- by @gianllopez (2026)

local M = {}

local DATA = vim.fn.stdpath("data") .. "/audit"

function M.root()
	local matches = vim.fs.find(".git", {
		upward = true,
		path = vim.fn.expand("%:p:h"),
	})

	if matches[1] then
		return vim.fs.dirname(matches[1])
	end

	return vim.fn.getcwd()
end

function M.relative(root)
	return vim.fn.expand("%:p"):sub(#root + 2)
end

function M.path(root)
	local hash = string.sub(vim.fn.sha256(root), 1, 8)

	vim.fn.mkdir(DATA, "p")

	return DATA .. "/" .. hash .. ".json"
end

function M.read(path)
	local f = io.open(path, "r")

	if not f then
		return {}
	end

	local content = f:read("*a")

	f:close()

	return vim.json.decode(content) or {}
end

function M.write(path, db)
	local f = io.open(path, "w")

	if not f then
		vim.notify("audit: could not write " .. path, vim.log.levels.ERROR, { title = "Audit" })
		return
	end

	f:write(vim.json.encode(db))

	f:close()
end

function M.entry()
	local root = M.root()
	local file = M.relative(root)

	if file == "" then
		return nil, nil
	end

	local database = M.read(M.path(root))

	return database[file], file
end

function M.save(status)
	local root = M.root()
	local file = M.relative(root)

	if file == "" then
		vim.notify("audit: no file open", vim.log.levels.WARN, { title = "Audit" })
		return
	end

	local path = M.path(root)
	local database = M.read(path)
	local entry = database[file] or { history = {} }
	local now = os.date("!%Y-%m-%dT%H:%M:%SZ")

	table.insert(entry.history, { status = status, at = now })

	entry.status = status

	database[file] = entry

	M.write(path, database)
end

return M
