return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 20,
			direction = "float",
			shade_terminals = false,
			start_in_insert = true,
			persist_mode = false,
			float_opts = {
				width = function()
					return math.floor(vim.o.columns * 0.9)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.9)
				end,
				border = "rounded",
			},
			close_on_exit = false,
			on_open = function(term)
				vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", { noremap = true, silent = true, buffer = term.bufnr })
			end,
		})
		vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

		local Terminal = require("toggleterm.terminal").Terminal
		local myterm = Terminal:new({ direction = "float", hidden = true })

		function _TOGGLE_MYTERM()
			myterm:toggle()
		end

		vim.keymap.set("n", "<leader>a", _TOGGLE_MYTERM, { noremap = true, silent = true })
	end,
}
