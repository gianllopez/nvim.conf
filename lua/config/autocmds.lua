local python_lsp = vim.api.nvim_create_augroup("python_lsp", { clear = true })
local custom = vim.api.nvim_create_augroup("custom", { clear = true })

-- [`python/lsp`]: disable hover capability from `ruff`

vim.api.nvim_create_autocmd("LspAttach", {
	group = python_lsp,
	pattern = "python",
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end
		if client.name == "ruff" then
			client.server_capabilities.hoverProvider = false
		end
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = custom,
	callback = function()
		vim.highlight.on_yank()
	end,
})
