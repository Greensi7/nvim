local fzf = require("fzf-lua")

fzf.setup({
	"max-perf",
	files = {
		hidden = true,
		no_ignore = false,
	},
	grep = {
		previewer = "builtin",
	},
	hls = {
		cursorline = "Visual",
		search = "IncSearch",
	},
	winopts = {
		preview = {
			default = "cat",
			hidden = true,
		},
	},
})

vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Fzf find files" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Fzf live grep" })
vim.keymap.set("n", "<leader>fm", fzf.manpages, { desc = "Fzf man pages" })
