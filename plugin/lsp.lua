-- Mason + LSP configuration
require("mason").setup()

local lsp_list_mason_install = {
	"tailwindcss",
	"vtsls",
	"lua_ls",
	"pyright",
	"gopls",
	"clangd",
	"docker_language_server",
	-- "nil_ls",
	-- "nixd",
	--"ltex",
	--"terraformls",
	--"yamlls",
	--"bashls"
}

require("mason-lspconfig").setup({
	ensure_installed = lsp_list_mason_install,
})

local lsp_list = vim.deepcopy(lsp_list_mason_install)
table.insert(lsp_list, "roslyn")
vim.lsp.enable(lsp_list)
