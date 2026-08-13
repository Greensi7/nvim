local gitsigns = require("gitsigns")

gitsigns.setup({
	attach_to_untracked = true,
	signs_staged_enable = true,
	on_attach = function(buffer)
		local function map(mode, lhs, rhs, description, options)
			options = options or {}
			options.buffer = buffer
			options.desc = description
			vim.keymap.set(mode, lhs, rhs, options)
		end

		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gitsigns.nav_hunk("next", { target = "all" })
			end)
			return "<Ignore>"
		end, "Next Git change", { expr = true })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gitsigns.nav_hunk("prev", { target = "all" })
			end)
			return "<Ignore>"
		end, "Previous Git change", { expr = true })

		map("n", "<leader>gp", gitsigns.preview_hunk_inline, "Preview Git change")
		map("n", "<leader>gd", function()
			local tab = vim.api.nvim_get_current_tabpage()
			local existing_windows = {}
			for _, window in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
				existing_windows[window] = true
			end

			gitsigns.diffthis("HEAD", {}, function(error)
				if error then
					vim.notify(error, vim.log.levels.ERROR)
					return
				end

				vim.schedule(function()
					if not vim.api.nvim_tabpage_is_valid(tab) or vim.api.nvim_get_current_tabpage() ~= tab then
						return
					end

					for _, window in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
						if not existing_windows[window] and vim.wo[window].diff then
							vim.api.nvim_set_current_win(window)
							return
						end
					end
				end)
			end)
		end, "Diff file against last commit")
		map("n", "<leader>gS", gitsigns.toggle_signs, "Toggle Git signs")
	end,
})
