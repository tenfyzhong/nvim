--[[
- @file vim-grepper.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 23:03:42
--]]

local grepper = {
    'mhinz/vim-grepper',
    config = function()
        vim.g.grepper = {
            highlight = 1,
            tools = { 'ag' },
        }

        vim.api.nvim_create_user_command('Todo',
            "Grepper -noprompt -tool ag -grepprg ag --vimgrep '(\bTODO\b|\bBUG\b|\bERROR\b)'", {})
        vim.keymap.set({ 'n', 'x' }, 'gp', '<plug>(GrepperOperator)', { remap = true, desc = 'grpper: grep' })
        vim.keymap.set({ 'n' }, '<leader>*', ':Grepper -tool ag -cword -noprompt<cr>',
            { remap = false, desc = 'grepper: grep cword' })
    end,
    event = 'VeryLazy',
}

return { grepper }
