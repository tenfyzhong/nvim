--[[
- @file vim-fugitive.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 10:06:47
--]]

local function fugitive_config()
    vim.keymap.set('n', '<leader>gw', ':Gwrite<cr>',
        { silent = true, remap = false, desc = 'fugitive: add current to git index' })
    vim.keymap.set('n', '<leader>gc', ':Git commit<cr>', { silent = true, remap = false, desc = 'fugitive: git commit' })
    vim.keymap.set('n', '<leader>gb', ':Git blame<cr>', { silent = true, remap = false, desc = 'fugitive: git blame' })
    vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit<cr>',
        { silent = true, remap = false, desc = 'fugitive: git diff vsplit' })
    vim.keymap.set('n', '<leader>gl', ':silent Gclog!<cr>', { silent = true, remap = false, desc = 'fugitive: git log' })
    vim.keymap.set('n', '<leader>gt', ':Git<cr>', { silent = true, remap = false, desc = 'fugitive: git' })
    vim.keymap.set('n', '<leader>gf', ':GBrowse<cr>', { silent = true, remap = false, desc = 'fugitive: git browse' })
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

local fugitive = { 'tpope/vim-fugitive', config = fugitive_config }
local rhubarb = { 'tpope/vim-rhubarb', dependencies = { fugitive[1] } }
local gitlab = { 'shumphrey/fugitive-gitlab.vim', dependencies = { fugitive[1] } }

return { fugitive, rhubarb, gitlab }
