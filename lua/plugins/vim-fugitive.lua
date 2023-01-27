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

local fugitive = { 'tpope/vim-fugitive', config = fugitive_config }
local rhubarb = { 'tpope/vim-rhubarb', requires = fugitive[1] }
local gitlab = { 'shumphrey/fugitive-gitlab.vim', requires = fugitive[1] }

return { fugitive, rhubarb, gitlab }
