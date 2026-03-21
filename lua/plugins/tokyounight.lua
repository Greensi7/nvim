return {
	"folke/tokyonight.nvim",
	lazy = false, -- load it eagerly on startup
	priority = 1000, -- high priority so colorscheme loads first
	config = function()
		require("tokyonight").setup({
			style = "storm",
			transparent = false,
			on_highlights = function(hl, c)
				local cl = c.blue
				local cl_com = "#03045e"
				local cl_com_bg = "#caf0f8"
				hl.LineNr = { fg = cl } -- or try c.cyan, c.purple, c.magenta, etc.
				hl.LineNrAbove = { fg = cl }
				hl.LineNrBelow = { fg = cl }
				hl.Comment = { fg = cl_com, bg = cl_com_bg, italic = true }
				hl["@comment"] = { fg = cl_com, bg = cl_com_bg, italic = true }
				--hl.BlinkCmpGhostText = { }

				hl.CursorLineNr = { fg = c.orange, bold = true }
			end,
		})
		vim.cmd([[colorscheme tokyonight-night]])
	end,
}
