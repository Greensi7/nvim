-- Telescope fuzzy finder configuration
require("telescope").setup({
	defaults = {
		file_ignore_patterns = {
			"bin/",
			".idea",
			"node_modules/",
			"^.git/",
			"__pycache__",
			".DS_Store",
		},
	},
	pickers = {
		find_files = {
			-- Show hidden files (like .gitignore, .env)
			hidden = true,
			-- Don't respect .gitignore (show node_modules, build, etc.)
			no_ignore = true,
		},
	},
})

-- Telescope keymaps
local builtin = require("telescope.builtin")
--vim.keymap.set("n", "<leader>fk", builtin, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>ff", function()
	builtin.find_files({ hidden = true })
end, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fm", builtin.man_pages, { desc = "Telescope man pages" })
