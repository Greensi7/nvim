return {
	cmd = { "clangd", "--compile-commands-dir", "build"},
	filetypes = { "c" },
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
