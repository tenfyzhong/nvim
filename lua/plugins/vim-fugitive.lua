--[[
- @file vim-fugitive.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 10:06:47
--]]

local function fugitive_config()
    vim.keymap.set('n', '<leader>gw', ':Gwrite<cr>', { silent = true, remap = false })
    vim.keymap.set('n', '<leader>gc', ':Git commit<cr>', { silent = true, remap = false })
    vim.keymap.set('n', '<leader>gb', ':Git blame<cr>', { silent = true, remap = false })
    vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit<cr>', { silent = true, remap = false })
    vim.keymap.set('n', '<leader>gl', ':silent Gclog!<cr>', { silent = true, remap = false })
    vim.keymap.set('n', '<leader>gs', ':Git<cr>', { silent = true, remap = false })
    vim.keymap.set('n', '<leader>ghf', ':GBrowse<cr>', { silent = true, remap = false })
end

local fugitive = {
    'tpope/vim-fugitive',
    config = fugitive_config,
    cmd = { 'G', 'Git', 'Ggrep', 'Glgrep', 'Gclog', 'Gllog', 'Gcd', 'Glcd', 'Gedit', 'Gsplit', 'Gvsplit', 'Gtabedit',
        'Gpedit', 'Gdrop', 'Gread', 'Gwrite', 'Gwq', 'Gdiffsplit', 'Gvdiffsplit', 'Ghdiffsplit', 'GMove', 'GRename',
        'GDelete', 'GRemove', 'GUnlink', 'GBrowse' },
    keys = { '<leader>gw', '<leader>gc', '<leader>gb', '<leader>gd', '<leader>gl', '<leader>gs', '<leader>ghf' },
}
local rhubarb = { 'tpope/vim-rhubarb', requires = fugitive[1], ft = 'gitcommit', cmd = 'GBrowse' }
local gitlab = { 'shumphrey/fugitive-gitlab.vim', requires = fugitive[1], ft = 'gitcommit', cmd = 'GBrowse' }

return { fugitive, rhubarb, gitlab }
