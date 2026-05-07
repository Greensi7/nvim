-- conform.nvim formatting configuration
require("conform").setup({
	-- Define your formatters
	formatters_by_ft = {
		lua = { "stylua", lsp_format = "fallback" },
		python = { "isort", "black", lsp_format = "fallback" },
		rust = { "rustfmt", lsp_format = "fallback" },
		json = { "jsonf" },
		css = { "prettierd" },
		html = { "prettierd" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
	},
	formatters = {
		jsonf = {
			command = "deno",
			args = {
				"fmt",
				"--indent-width",
				"4",
				"$FILENAME",
			},
			stdin = false,
		},
	},
	-- Set default options
	default_format_opts = {
		lsp_format = "fallback",
	},
	-- Set up format-on-save
	format_on_save = { timeout_ms = 500 },
})

-- Format buffer keymap
vim.keymap.set("", "<leader>fb", function()
	require("conform").format({ async = true })
end, { desc = "Format buffer" })
