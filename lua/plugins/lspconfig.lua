
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


return { -- language support
	"neovim/nvim-lspconfig",
	config = function()
		vim.lsp.config["rust_analyzer"] = {
			settings = {
				["rust-analyzer"] = {
					check = {
						command = "clippy"
					}
				}
			}
		}
		vim.lsp.enable({
			"gopls",
			"jdtls",
			"kotlin_language_server",
			"lua_ls",
			"pylsp",
			"rust_analyzer",
			"ts_ls",
		})
	end,
}
