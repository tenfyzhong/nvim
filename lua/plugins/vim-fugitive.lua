--[[
- @file vim-fugitive.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 10:06:47
--]]

local function fugitive_config()
    vim.api.nvim_create_user_command('Gpush', function()
        local gitdir = vim.fn.FugitiveGitDir()
        local escape = vim.fn.fnamemodify(gitdir, ':p:h:h')
        local cmd = string.format(':AsyncRun -cwd=%s git push', escape)
        vim.cmd(cmd)
    end, {})
    vim.api.nvim_create_user_command('Gpull', function()
        local gitdir = vim.fn.FugitiveGitDir()
        local escape = vim.fn.fnamemodify(gitdir, ':p:h:h')
        local cmd = string.format(':AsyncRun -cwd=%s git pull', escape)
        vim.cmd(cmd)
    end, {})
end

local rhubarb = {
    'tpope/vim-rhubarb',
}
local gitlab = {
    'shumphrey/fugitive-gitlab.vim',
}

local fugitive = {
    'tpope/vim-fugitive',
    config = fugitive_config,
    dependencies = {
        rhubarb,
        gitlab,
    },
    cmd = {
        'G', 'Git', 'Ggrep', 'Glgrep', 'Gclog', 'Gllog', 'Gcd', 'Glcd', 'Gedit', 'Gsplit', 'Gvsplit', 'Gtabedit',
        'Gpedit', 'Gdrop', 'Gread', 'Gwrite', 'Gwq', 'Gdiffsplit', 'Gvdiffsplit', 'Ghdiffsplit', 'GMove', 'GRename',
        'GDelete', 'GRemove', 'GUnlink', 'GBrowse', 'Gpush', 'Gpull',
    },
    keys = {
        { '<leader>gw', ':Gwrite<cr>',        mode = 'n', silent = true, remap = false, desc = 'fugitive: add current to git index' },
        { '<leader>gc', ':Git commit<cr>',    mode = 'n', silent = true, remap = false, desc = 'fugitive: git commit' },
        { '<leader>gb', ':Git blame<cr>',     mode = 'n', silent = true, remap = false, desc = 'fugitive: git blame' },
        { '<leader>gd', ':Gvdiffsplit<cr>',   mode = 'n', silent = true, remap = false, desc = 'fugitive: git diff vsplit' },
        { '<leader>gl', ':silent Gclog!<cr>', mode = 'n', silent = true, remap = false, desc = 'fugitive: git log' },
        { '<leader>gt', ':Git<cr>',           mode = 'n', silent = true, remap = false, desc = 'fugitive: git' },
    },
}

return { fugitive }
