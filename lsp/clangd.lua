return {
	cmd = {
		"clangd",
		"--clang-tidy",
		"--function-arg-placeholders=0",
		--	"--header-insertion=iwyu",
		--	"--header-insertion-decorators",
	},
	filetypes = { "c", "cpp" },
	root_markers = { ".clang-tidy", ".clang-format", ".clangd" },
	settings = {
		clangd = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
}
