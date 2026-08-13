-- nvim-dap debugging configuration
local dap = require("dap")
local dapui = require("dapui")
local dap_python = require("dap-python")
require("dap-go").setup()

require("dapui").setup({})
require("nvim-dap-virtual-text").setup({
	commented = true, -- Show virtual text alongside comment
})

dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}

local function first_executable(paths)
	for _, path in ipairs(paths) do
		if vim.fn.executable(path) == 1 then
			return path
		end
	end
end

local lldb_dap = first_executable({
	"lldb-dap",
	"/Library/Developer/CommandLineTools/usr/bin/lldb-dap",
	"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/lldb-dap",
})

if lldb_dap ~= nil then
	dap.adapters.lldb = {
		type = "executable",
		command = lldb_dap,
		name = "lldb",
	}
else
	vim.notify("nvim-dap: lldb-dap not found", vim.log.levels.WARN)
end

dap.configurations.c = {
	{
		name = "Launch (LLDB)",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		args = function()
			local args = vim.fn.input("Arguments: ")
			return vim.split(args, " ", { trimempty = true })
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
	{
		name = "OpenSSL echstore_parser corpus (LLDB)",
		type = "lldb",
		request = "launch",
		program = "/Users/adamtabak/Documents/fuzzing/openssl/fuzz/echstore_parser",
		args = {
			"-runs=0",
			"-max_len=1500",
			"fuzz/corpora/echstore_parser",
		},
		cwd = "/Users/adamtabak/Documents/fuzzing/openssl",
		stopOnEntry = false,
	},
	{
		name = "Select and attach to process (LLDB)",
		type = "lldb",
		request = "attach",
		pid = function()
			local name = vim.fn.input("Executable name (filter): ")
			return require("dap.utils").pick_process({ filter = name })
		end,
		cwd = "${workspaceFolder}",
	},
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		args = {}, -- provide arguments if needed
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = false,
	},
	{
		name = "Select and attach to process",
		type = "gdb",
		request = "attach",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		pid = function()
			local name = vim.fn.input("Executable name (filter): ")
			return require("dap.utils").pick_process({ filter = name })
		end,
		cwd = "${workspaceFolder}",
	},
	{
		name = "Attach to gdbserver :1234",
		type = "gdb",
		request = "attach",
		target = "localhost:1234",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
	},
}
dap.configurations.cpp = dap.configurations.c

dap_python.setup("python3")

-- 2. ADD THIS: Inject the "Launch as Module" configuration
table.insert(dap.configurations.python, {
	type = "python",
	request = "launch",
	name = "Launch as Module (package)",
	-- This sets the python "-m" flag
	module = function()
		-- Ask for the module name when debugging starts
		-- Example input: "app.main" or "tests.test_api"
		return vim.fn.input("Module name: ")
	end,
	cwd = "${workspaceFolder}",
})

vim.fn.sign_define("DapBreakpoint", {
	text = "",
	texthl = "DiagnosticSignError",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
	text = "", -- or "❌"
	texthl = "DiagnosticSignError",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapStopped", {
	text = "", -- or "→"
	texthl = "DiagnosticSignWarn",
	linehl = "Visual",
	numhl = "DiagnosticSignWarn",
})

-- Automatically open/close DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

local opts = { noremap = true, silent = true }

-- Toggle breakpoint
vim.keymap.set("n", "<leader>db", function()
	dap.toggle_breakpoint()
end, opts)

-- Continue / Start
vim.keymap.set("n", "<leader>dc", function()
	dap.continue()
	vim.keymap.set("n", "<F5>", function()
		dap.continue()
	end, opts)
end, opts)

-- Step Over
vim.keymap.set("n", "<leader>do", function()
	dap.step_over()
end, opts)
vim.keymap.set("n", "<F10>", function()
	dap.step_over()
end, opts)

-- Step Into
vim.keymap.set("n", "<leader>di", function()
	dap.step_into()
end, opts)
vim.keymap.set("n", "<F11>", function()
	dap.step_into()
end, opts)

-- Step Out
vim.keymap.set("n", "<leader>dO", function()
	dap.step_out()
end, opts)
vim.keymap.set("n", "<S-F11>", function()
	dap.step_out()
end, opts)

-- Keymap to terminate debugging
vim.keymap.set("n", "<leader>dq", function()
	require("dap").terminate()
end, opts)
vim.keymap.set("n", "<S-F5>", function()
	require("dap").terminate()
end, opts)

-- Toggle DAP UI
vim.keymap.set("n", "<leader>du", function()
	dapui.toggle()
end, opts)
