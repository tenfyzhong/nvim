--[[
- @file fzf.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 20:06:26
--]]

local fzf = {
    'junegunn/fzf',
    run = ":call fzf#install()",
}

local fzf_vim = {
    'junegunn/fzf.vim',
    requires = fzf[1],
    config = function()
        vim.g.fzf_command_prefix = 'FZF'
        vim.g.fzf_history_dir = '~/.fzf-history'

        vim.keymap.set('n', '<leader>fp', ':FZF', { silent = true, remap = false })
        vim.keymap.set('n', '<leader>ff', ':FZFFiles<cr>', { silent = true, remap = false })
        vim.keymap.set('n', '<leader>fg', ':FZFGFiles<cr>', { silent = true, remap = false })
        vim.keymap.set('n', '<leader>fb', ':FZFBuffers<cr>', { silent = true, remap = false })
        vim.keymap.set('n', '<leader>fa', ':FZFAg<cr>', { silent = true, remap = false })
        vim.keymap.set('n', '<leader>fA', function()
            local cword = vim.fn.expand('<cword>')
            vim.cmd('FZFAg ' .. cword .. '<cr>')
        end, { silent = true, remap = false })
        vim.keymap.set('n', '<leader>fh', ':FZFHistory<cr>', { silent = true, remap = false })
        vim.keymap.set('n', '<leader>fw', ':FZFWindows<cr>', { silent = true, remap = false })
        vim.keymap.set('n', '<leader>fc', ':FZFCommands<cr>', { silent = true, remap = false })
        vim.keymap.set('n', '<leader>/', ':FZFHistory/<cr>', { silent = true, remap = false })
        vim.keymap.set('n', '<leader>fT', ':FZFTags<cr>', { silent = true, remap = false })
        vim.keymap.set('n', '<leader>fm', ':FZFMarks<cr>', { silent = true, remap = false })

        vim.keymap.set({ 'n' }, '<leader><leader>', '<plug>(fzf-maps-n)', { silent = false, remap = true })
        vim.keymap.set({ 'o' }, '<leader><leader>', '<plug>(fzf-maps-o)', { silent = false, remap = true })
        vim.keymap.set({ 'x' }, '<leader><leader>', '<plug>(fzf-maps-x)', { silent = false, remap = true })

        local group = vim.api.nvim_create_augroup('fzf_local', {})
        vim.api.nvim_create_autocmd('User', {
            group = group,
            pattern = 'FZFMarksCd',
            callback = function()
                local tabnr = vim.fn.tabpagenr()
                local name = 'defx' .. tabnr
                vim.cmd('Defx -buffer-name=' .. name)
            end,
        })
        vim.api.nvim_create_autocmd('FileType', {
            group = group,
            pattern = 'thrift',
            callback = function()
                vim.keymap.set('n', '<leader>ft', ':FZFBTags<cr>', { silent = true, buffer = true, remap = false })
            end,
        })
    end
}

local marks = {
    'tenfyzhong/fzf-marks.vim',
    requires = fzf[1],
    config = function()
        vim.keymap.set('n', '<leader>fz', ':FZFFzm<cr>', { silent = true, remap = false })
    end,
}

local bookmarks = {
    'tenfyzhong/fzf-bookmarks.vim',
    requires = fzf[1],
    config = function()
        vim.keymap.set('n', '<leader>fM', ':FZFBookmarks<cr>', { silent = true, remap = false })
    end,
}

return { fzf, fzf_vim, marks, bookmarks }
