-- ==========================================================================
-- Neovim options, keymaps, and autocmds
-- Plugin declarations are in plugin/00-packs.lua
-- Plugin configs are in plugin/*.lua
-- ==========================================================================

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.cursorline = true -- line highlight
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.o.winborder = "rounded"

vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>sl", function()
	local lsp_list = vim.lsp.get_clients()
	for _, client in ipairs(lsp_list) do
		vim.lsp.stop_client(client.id)
	end
	vim.defer_fn(function()
		vim.cmd("edit")
		vim.notify("Lsp Servers Restarted", 1)
	end, 500)
end)

vim.keymap.set("n", "<leader>ss", function()
	vim.cmd("source $MYVIMRC")
	vim.cmd("echo 'sourced' $MYVIMRC", 1)
end)

vim.keymap.set("n", "<leader>sc", function()
	local buf_id = vim.api.nvim_win_get_buf(0)
	local buf_name = vim.fn.bufname(buf_id)
	vim.cmd("source " .. buf_name)
	vim.notify("sourced " .. buf_name, 1)
end)

vim.keymap.set("x", "p", [["_dP]])
vim.keymap.set("n", "<leader><leader>", "<cmd>b#<CR>", { desc = "Mvoe to the previous buffer" })

--vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, { desc = "Format Buffer" })

vim.api.nvim_set_keymap("n", "<leader>/", ":nohlsearch<CR>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("FocusLost", {
	callback = function()
		if vim.bo.modified and vim.bo.buftype == "" then
			vim.cmd("silent! update")
		end
	end,
})

vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover()
end, { noremap = true, silent = true })

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- go to definition
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- find references
vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- go to implementation

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic message" })
vim.keymap.set("n", "<leader>E", vim.diagnostic.setloclist, { desc = "Show list of errors" })
