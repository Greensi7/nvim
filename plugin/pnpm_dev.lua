local current_job_id = nil
local function start_pnpm()
	if current_job_id then
		vim.notify("Pnpm server is already running.", vim.log.levels.WARN)
		return
	end

	local job_opts = {
		env = { BROWSER = "safari" },
		cwd = vim.fn.getcwd(),
		on_exit = function(job_id, exit_code, event)
			current_job_id = nil
			vim.notify("pnpm dev ended (code: " .. exit_code .. ")", vim.log.levels.INFO)
		end,

		on_stderr = function(job_id, data, event)
			local msg = table.concat(data, "\n")
			if msg and msg ~= "" then
				vim.notify("pnpm stderr: " .. msg, vim.log.levels.ERROR)
			end
		end,

		--on_stdout = function(job_id, data, event)
		--	local msg = table.concat(data, "\n")
		--	if msg and msg ~= "" then
		--		vim.notify("pnpm stdout: " .. msg, vim.log.levels.INFO)
		--	end
		--end,
	}

	local job_id = vim.fn.jobstart({ "pnpm", "dev", "--host", "--open" }, job_opts)

	if job_id <= 0 then
		vim.notify("Failed to start pnpm dev", vim.log.levels.ERROR)
	else
		current_job_id = job_id
		vim.notify("Started pnpm dev with job ID: " .. job_id, vim.log.levels.INFO)
	end
end

local function stop_pnpm()
	if not current_job_id then
		vim.notify("Pnpm dev is not running.")
		return
	end

	local status = vim.fn.jobstop(current_job_id)
	if status == 0 then
		vim.notify("Invalid pnpm dev job id.", vim.log.levels.ERROR)
	end
end

vim.keymap.set("n", "<leader>pm", start_pnpm)
vim.keymap.set("n", "<leader>pq", stop_pnpm)
