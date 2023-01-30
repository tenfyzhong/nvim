--[[
- @file keymap.lua
- @brief global keymap
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-26 22:09:22
--]]


local function write_redraw()
    vim.cmd('silent wa')
    vim.cmd('redraw!')
    print(':wa')
end

local function diffget()
    vim.cmd('diffget')
    vim.cmd('diffupdate')
end

local function diffput()
    vim.cmd('diffput')
    vim.cmd('diffupdate')
end

vim.keymap.set({ 'n' }, '<leader>', '<NOP>', { silent = true, remap = false })
vim.keymap.set({ 'n' }, 'gj', 'j', { silent = true, remap = false })
vim.keymap.set({ 'n' }, 'gk', 'k', { silent = true, remap = false })
vim.keymap.set({ 'i', 'c' }, '<c-k>', '<Up>', { silent = true, remap = false })
vim.keymap.set({ 'i', 'c' }, '<c-j>', '<Down>', { silent = true, remap = false })
vim.keymap.set({ 'n', 'x' }, ';', ':', { silent = false, remap = false })
vim.keymap.set({ 'n' }, ',', ';', { silent = true, remap = false })
vim.keymap.set({ 'n' }, '<leader>w', write_redraw, { silent = true, remap = false })
vim.keymap.set({ 'n' }, 'do', diffget, { silent = true, remap = false })
vim.keymap.set({ 'n' }, 'dp', diffput, { silent = true, remap = false })
vim.keymap.set({ 'n' }, '<leader>nn', function() require('feature').PollNumber() end, { silent = true, remap = false })
vim.keymap.set({ 'v' }, '<', '<gv', { remap = false })
vim.keymap.set({ 'v' }, '>', '>gv', { remap = false })
vim.keymap.set({ 'n' }, '<leader>tn', function() vim.cmd('tabnew') end, { silent = true, remap = false })
vim.keymap.set({ 'n' }, '<leader>tc', function() vim.cmd('tabclose') end, { silent = true, remap = false })
vim.keymap.set({ 'n' }, '<Space>', '<NOP>', { silent = true, remap = false })
vim.keymap.set({ 'n' }, '<Space><Space>', 'zA', { silent = true, remap = false })
vim.keymap.set({ 'n' }, '<c-w>\\', '<c-w>v', { silent = true, remap = false })
vim.keymap.set({ 'n' }, '<c-w>-', '<c-w>s', { silent = true, remap = false })
vim.keymap.set({ 'n' }, 'n', function() return vim.v.searchforward and 'n' or 'N' end, { expr = true, remap = false })
vim.keymap.set({ 'n' }, 'N', function() return vim.v.searchforward and 'N' or 'n' end, { expr = true, remap = false })
vim.keymap.set({ 'n' }, '<leader>y', '"*y', { remap = false })
vim.keymap.set({ 'n' }, '<esc><esc>', function() vim.cmd('nohlsearch') end, { silent = true })
