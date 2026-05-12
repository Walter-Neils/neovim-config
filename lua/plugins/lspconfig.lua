vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(ev)
		-- Enable Inlay Hints for the current buffer
		-- Note: This requires the LSP to support it.
		-- rust_analyzer supports this out of the box.
		if vim.lsp.inlay_hint then
			vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
		end
	end,
})

local function apply_configuration_extensions()
	local lsp_config_path = vim.fn.stdpath("config") .. "/lua/plugins/lsp"
	local scanner = vim.uv.fs_scandir(lsp_config_path)
	if scanner then
		while true do
			local name, type = vim.uv.fs_scandir_next(scanner)
			if not name then
				break
			end

			-- 2. Only process .lua files and ignore folders
			if type == "file" and name:match("%.lua$") then
				-- Strip the .lua extension for require
				local mod_name = name:gsub("%.lua$", "")
				local require_path = "plugins.lsp." .. mod_name

				-- 3. Use pcall to prevent one bad config from breaking everything
				local status_ok, result = pcall(require, require_path)

				if not status_ok then
					vim.notify("Failed to load LSP config: " .. mod_name .. "\n" .. result, vim.log.levels.ERROR)
				else
					vim.lsp.config(mod_name, result)
					vim.lsp.enable(mod_name, true)
				end
			end
		end
	end
end

return { -- language support
	"neovim/nvim-lspconfig",
	config = function()
		apply_configuration_extensions()
		vim.lsp.enable({
			-- "gopls",
			-- "jdtls",
			-- "kotlin_language_server",
			"lua_ls",
			-- "pylsp",
			"rust_analyzer",
			"bashls",
			"vtsls",
			"fish_lsp",
			-- "ts_ls",
		})
	end,
}
