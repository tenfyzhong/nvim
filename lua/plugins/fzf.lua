--[[
- @file fzf.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 20:06:26
--]]

local fzf_vim = {
    'junegunn/fzf.vim',
    config = function()
        vim.g.fzf_command_prefix = 'FZF'
        vim.g.fzf_history_dir = '~/.fzf-history'

        vim.keymap.set('n', '<leader>ff', ':FZFFiles<cr>', { silent = true, remap = false, desc = 'fzf: files' })
        vim.keymap.set('n', '<leader>fg', ':FZFGFiles<cr>', { silent = true, remap = false, desc = 'fzf: git files' })
        vim.keymap.set('n', '<leader>fb', ':FZFBuffers<cr>', { silent = true, remap = false, desc = 'fzf: buffers' })
        vim.keymap.set('n', '<leader>fa', ':FZFAg<cr>', { silent = true, remap = false, desc = 'fzf: ag' })
        vim.keymap.set('n', '<leader>fA', function()
            local cword = vim.fn.expand('<cword>')
            vim.cmd(vim.g.fzf_command_prefix .. 'Ag ' .. cword .. '<cr>')
        end, { silent = true, remap = false, desc = 'fzf: ag cword' })
        vim.keymap.set('n', '<leader>fh', ':FZFHistory<cr>',
            { silent = true, remap = false, desc = 'fzf: command history' })
        vim.keymap.set('n', '<leader>fw', ':FZFWindows<cr>', { silent = true, remap = false, desc = 'fzf: windows' })
        vim.keymap.set('n', '<leader>fc', ':FZFCommands<cr>', { silent = true, remap = false, desc = 'fzf: commands' })
        vim.keymap.set('n', '<leader>/', ':FZFHistory/<cr>',
            { silent = true, remap = false, desc = 'fzf: search history' })
        vim.keymap.set('n', '<leader>fT', ':FZFTags<cr>', { silent = true, remap = false, desc = 'fzf: ctags' })
        vim.keymap.set('n', '<leader>fm', ':FZFMarks<cr>', { silent = true, remap = false, desc = 'fzf: marks' })

        vim.keymap.set({ 'n' }, '<leader><leader>', '<plug>(fzf-maps-n)',
            { silent = false, remap = true, desc = 'fzf: nmap' })
        vim.keymap.set({ 'o' }, '<leader><leader>', '<plug>(fzf-maps-o)',
            { silent = false, remap = true, desc = 'fzf: omap' })
        vim.keymap.set({ 'x' }, '<leader><leader>', '<plug>(fzf-maps-x)',
            { silent = false, remap = true, desc = 'fzf: xmap' })

        local group = vim.api.nvim_create_augroup('fzf_local', {})
        vim.api.nvim_create_autocmd('FileType', {
            group = group,
            pattern = 'thrift',
            callback = function()
                vim.keymap.set('n', '<leader>ft', ':FZFBTags<cr>',
                    { silent = true, buffer = true, remap = false, desc = 'fzf: buffer tags' })
            end,
        })
        vim.api.nvim_create_autocmd('FileType', {
            group = group,
            pattern = 'defx',
            callback = function()
                vim.keymap.set('n', '<leader>ft', ':FZFBLines<cr>',
                    { silent = true, buffer = true, remap = false, desc = 'fzf:buffer tags' })
            end,
        })
    end,
}

local marks = {
    'tenfyzhong/fzf-marks.vim',
    config = function()
        vim.keymap.set('n', '<leader>fs', ':FZFFzm<cr>', { silent = true, remap = false, desc = 'fzf-marks: marks' })
        local group = vim.api.nvim_create_augroup('fzf_marks_local', {})
        vim.api.nvim_create_autocmd('User', {
            group = group,
            pattern = 'FZFMarksCd',
            callback = function() require('feature').DefxCwd() end,
        })
    end,
}

local bookmarks = {
    'tenfyzhong/fzf-bookmarks.vim',
    config = function()
        vim.keymap.set('n', '<leader>fM', ':FZFBookmarks<cr>',
            { silent = true, remap = false, desc = 'fzf-bookmarks: bookmarks' })
    end,
}

local z = {
    'tenfyzhong/z.nvim',
    config = function()
        require('z').setup {}

        vim.keymap.set('n', '<leader>fz', ':FZFZ<cr>', { silent = true, remap = false, desc = 'z: z' })
        local group = vim.api.nvim_create_augroup('z_local', {})
        vim.api.nvim_create_autocmd('User', {
            group = group,
            pattern = 'Zcd',
            callback = function() require('feature').DefxCwd() end,
        })
    end,
}

local fzf = {
    'junegunn/fzf',
    build = ":call fzf#install()",
    event = 'VeryLazy',
    dependencies = {
        fzf_vim,
        marks,
        bookmarks,
        z,
    },
}


return { fzf }
