local map = vim.keymap.set


-- Movement Keys
; (function()
	local keys = { h = "<Left>", j = "<Down>", k = "<Up>", l = "<Right>" }
	for key, move in pairs(keys) do
		map("n", "<C-" .. key .. ">", "<C-w>" .. key, {})
	end
	for key, move in pairs(keys) do
		map("i", "<C-" .. key .. ">", move, { desc = "Move cursor in insert mode" })
	end
end)()

map("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Open File Explorer" })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		vim.keymap.set("n", "<leader>fm", function()
			require("conform").format({ bufnr = vim.api.nvim_get_current_buf()
		})
		end, { buffer = ev.buf })
	end
})

vim.keymap.set(
	"",
	"<Leader>i",
	function()
		local already_active = vim.lsp.inlay_hint.is_enabled();
		vim.lsp.inlay_hint.enable(not already_active)
		vim.diagnostic.config({virtual_lines = not already_active})
	end,
	{ desc = "Toggle lsp_lines" }
)

vim.keymap.set({ "n", "x" }, "<leader>ca", function()
	require("tiny-code-action").code_action()
end, { noremap = true, silent = true })

map({"n", "x", "t"}, "<A-i>", function() 
	vim.cmd("ToggleTerm cmd=tmux")
end, {noremap = true, silent = true})

vim.keymap.set("i", "<C-i>", "<cmd>Lspsaga signature_help<CR>", { desc = "Signature Help", buffer = vim.api.nvim_get_current_buf() })

vim.keymap.set({ "n", "v" }, "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })
