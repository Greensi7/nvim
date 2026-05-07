-- ==========================================================================
-- Plugin declarations via vim.pack (Neovim 0.12 native plugin manager)
-- This file is prefixed with 00- so it sources FIRST (alphabetical order)
-- ==========================================================================

-- Hooks: run before vim.pack.add() so install hooks work on bootstrap
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		-- Rebuild treesitter parsers on update
		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

-- All plugins: installed into site/pack/core/opt and loaded via :packadd
vim.pack.add({
	-- Colorscheme (must load eagerly)
	"https://github.com/folke/tokyonight.nvim",

	-- Treesitter
	"https://github.com/nvim-treesitter/nvim-treesitter",

	-- LSP tooling
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",

	-- Telescope + dependency
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",

	-- Harpoon (pinned to harpoon2 branch)
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },

	-- Completion
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") },
	"https://github.com/rafamadriz/friendly-snippets",

	-- Formatting
	"https://github.com/stevearc/conform.nvim",

	-- Terminal
	"https://github.com/akinsho/toggleterm.nvim",

	-- Hardtime + dependency
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/m4xshen/hardtime.nvim",

	-- Notifications
	"https://github.com/rcarriga/nvim-notify",

	-- DAP + dependencies
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/mfussenegger/nvim-dap-python",
	"https://github.com/theHamsta/nvim-dap-virtual-text",
	"https://github.com/leoluz/nvim-dap-go",
})
