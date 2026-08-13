return {
	cmd = {
		"clangd",
		"--clang-tidy",
		"--function-arg-placeholders=0",
		"--compile-commands-dir=/Users/adamtabak/Documents/fuzzing/openssl/",
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
