return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)

				local ft = vim.bo.filetype
				if ft and ft ~= "" then
					pcall(function()
						require("nvim-treesitter").install({ ft })
					end)
				end
			end,
		})
	end,
}
