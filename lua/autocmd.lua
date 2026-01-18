local init_group = vim.api.nvim_create_augroup("global_initial", {})

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
        if vim.fn.executable("direnv") == 0 then
            vim.notify("direnv not found", vim.log.levels.WARN)
            return
        end

        local cmd = { "direnv", "allow" }
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
                            vim.notify("direnv allow failed: " .. msg, vim.log.levels.WARN)
                        else
                            vim.notify("direnv allow failed", vim.log.levels.WARN)
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
                        vim.notify("direnv allow failed", vim.log.levels.WARN)
                    end)
                end
            end,
        })
        if not ok then
            vim.notify("direnv allow failed to start", vim.log.levels.WARN)
        end
    end,
})
