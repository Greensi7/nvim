return {
	cmd = { "roslyn-language-server", "--autoLoadProjects", "--stdio" },
	filetypes = {
		"cs", -- Standard C# code files
		"razor", -- Blazor / Razor components
		"cshtml",
	},
	settings = {},
	root_dir = function(bufnr, on_dir)
		local file_path = vim.api.nvim_buf_get_name(bufnr)
		local root = vim.fs.root(file_path, function(name, path)
			return name:match("%.csproj$") ~= nil -- Lua pattern matching for .csproj
		end)

		if root then
			on_dir(root)
		end
	end,
}
