local init_group = vim.api.nvim_create_augroup("global_initial", {})
local espanso_config_dir = vim.fn.fnamemodify("~/.config/espanso", ":p"):gsub("/+$", "")

local function is_path_in_dir(path, dir)
    local normalized_path = vim.fn.fnamemodify(path, ":p"):gsub("/+$", "")
    return normalized_path == dir or normalized_path:sub(1, #dir + 1) == dir .. "/"
end

local function run_async_command(cmd, opts)
    if vim.fn.executable(cmd[1]) == 0 then
        vim.notify(opts.missing_message, vim.log.levels.WARN)
        return
    end

    if vim.system then
        vim.system(cmd, { text = true }, function(result)
            if result.code ~= 0 then
                local msg = result.stderr or ""
                if msg == "" then
                    msg = result.stdout or ""
                end
                msg = vim.trim(msg)
                vim.schedule(function()
                    if msg ~= "" then
                        vim.notify(opts.failure_message .. ": " .. msg, vim.log.levels.WARN)
                    else
                        vim.notify(opts.failure_message, vim.log.levels.WARN)
                    end
                end)
            end
        end)
        return
    end

    local ok = pcall(vim.fn.jobstart, cmd, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_exit = function(_, code, _)
            if code ~= 0 then
                vim.schedule(function()
                    vim.notify(opts.failure_message, vim.log.levels.WARN)
                end)
            end
        end,
    })
    if not ok then
        vim.notify(opts.start_failure_message, vim.log.levels.WARN)
    end
end

vim.api.nvim_create_autocmd("BufWritePost", {
    group = init_group,
    pattern = { "*vimrc", "*.vim" },
    callback = function()
        vim.cmd("source %")
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    group = init_group,
    pattern = "*",
    callback = function()
        vim.o.paste = false
    end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
    group = init_group,
    pattern = "*",
    callback = function()
        vim.o.number = true
        vim.o.relativenumber = false
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    group = init_group,
    pattern = "*",
    callback = function()
        vim.o.number = true
        vim.o.relativenumber = true
    end,
})

vim.api.nvim_create_autocmd("WinLeave", {
    group = init_group,
    pattern = "*",
    callback = function()
        vim.wo.cursorline = false
    end,
})

vim.api.nvim_create_autocmd("WinEnter", {
    group = init_group,
    pattern = "*",
    callback = function()
        vim.wo.cursorline = true
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = init_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    group = init_group,
    pattern = ".envrc",
    callback = function()
        run_async_command({ "direnv", "allow" }, {
            missing_message = "direnv not found",
            failure_message = "direnv allow failed",
            start_failure_message = "direnv allow failed to start",
        })
    end,
})
