function get_pos_content(start_lnum, start_col, end_lnum, end_col) -- 1-indexed
    if start_lnum == 0 or start_col == 0 or end_lnum == 0 or end_col == 0 then
        return nil
    end
    local n_lines = math.abs(end_lnum - start_lnum) + 1
    local lines = vim.api.nvim_buf_get_lines(0, start_lnum - 1, end_lnum, false)
    lines[1] = string.sub(lines[1], start_col, -1)
    if n_lines == 1 then
        lines[n_lines] = string.sub(lines[n_lines], 1, end_col - start_col + 1)
    else
        lines[n_lines] = string.sub(lines[n_lines], 1, end_col)
    end
    return table.concat(lines, '\n')
end

function get_visual_selection()
    local s_start = vim.fn.getpos("'<")
    local s_end = vim.fn.getpos("'>")
    return get_pos_content(s_start[2], s_start[3], s_end[2], s_end[3])
end

function grep_motion()
    local old_func = vim.go.operatorfunc
    _G.op_func_grug_far = function()
        -- the col is 0-indexed
        -- we should translate it to 1-indexed
        local s_start = vim.api.nvim_buf_get_mark(0, '[')
        local s_end = vim.api.nvim_buf_get_mark(0, ']')
        local content = get_pos_content(s_start[1], s_start[2] + 1, s_end[1], s_end[2] + 1)
        if continue ~= nil then
            require('grug-far').open({ prefills = { search = content } })
        end
        vim.go.operatorfunc = old_func
        _G.op_func_grug_far = nil
    end
    vim.go.operatorfunc = 'v:lua.op_func_grug_far'
    vim.api.nvim_feedkeys('g@', 'n', false)
end

local far = {
    'MagicDuck/grug-far.nvim',
    config = function()
        require('grug-far').setup({
            -- options, see Configuration section below
            -- there are no required options atm
            -- engine = 'ripgrep' is default, but 'astgrep' can be specified
        });

        vim.api.nvim_create_user_command('Todo',
            function()
                require('grug-far').open({ prefills = { search = "TODO" } })
            end,
            { desc = 'grepper: Find todo bug error' })
    end,
    cmd = { 'GrugFar', 'Todo' },
    keys = {
        {
            '<leader>*',
            function()
                local word = '\\b' .. vim.fn.expand("<cword>") .. '\\b'
                require('grug-far').open({ prefills = { search = word } })
            end,
            mode = { 'n' },
            remap = false,
            desc = 'grug-far: grep cword',
        },
        {
            '<leader>*',
            function()
                local word = get_visual_selection()
                require('grug-far').open({ prefills = { search = word } })
            end,
            mode = { 'x' },
            remap = false,
            desc = 'grug-far: grep cword',
        },
        {
            '<leader>gr',
            function()
                grep_motion()
            end,
            mode = { 'n' },
            remap = false,
            desc = 'grug-far: grep keyword with motion',
        },
    }
}

return { far }
