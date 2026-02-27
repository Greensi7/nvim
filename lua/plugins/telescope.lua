return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		defaults = {
			file_ignore_patterns = {
                "bin/",
                ".idea",
                "node_modules/",
				"^.git/",
				"__pycache__",
                ".DS_Store"
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
	},
}
