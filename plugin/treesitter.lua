-- Treesitter configuration

-- Filetypes that don't have a treesitter parser (suppress warnings)
local ts_skip = {
	netrw = true,
	toggleterm = true,
	checkhealth = true,
	help = true,
	qf = true,
}

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		local ft = vim.bo.filetype
		if not ft or ft == "" or ts_skip[ft] then
			return
		end

		pcall(vim.treesitter.start)
		pcall(function()
			require("nvim-treesitter").install({ ft })
		end)
	end,
})
