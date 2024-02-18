--[[
- @file fzf.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 20:06:26
--]]


local fzf = {
    'junegunn/fzf',
    build = ":call fzf#install()",
    lazy = true,
}

local function find_tag()
    if vim.bo.filetype == 'thrift' then
        vim.cmd('silent FZFBTags')
    elseif vim.bo.filetype == 'NvimTree' or vim.bo.filetype == 'neo-tree' then
        vim.cmd('silent FZFBLines')
    elseif vim.bo.filetype == 'fish' then
        vim.cmd('silent FZFBTags')
    else
        vim.fn['aerial#fzf']()
    end
end

local fzf_vim = {
    'junegunn/fzf.vim',
    -- event = 'VeryLazy',
    dependencies = { 'stevearc/aerial.nvim', fzf[1] },
    init = function()
        vim.g.fzf_command_prefix = 'FZF'
        vim.g.fzf_history_dir = '~/.fzf-history'
    end,
    config = function() end,
    cmd = { 'FZF', 'FZFFiles', 'FZFGFiles', 'FZFBuffers', 'FZFRg', 'FZFAg' },
    keys = {
        { '<leader>ff', ':FZFFiles<cr>',   silent = true, remap = false, desc = 'fzf: files' },
        { '<leader>fg', ':FZFGFiles<cr>',  silent = true, remap = false, desc = 'fzf: git files' },
        { '<leader>fb', ':FZFBuffers<cr>', silent = true, remap = false, desc = 'fzf: buffers' },
        { '<leader>fr', ':FZFRg<cr>',      silent = true, remap = false, desc = 'fzf: rg' },
        { '<leader>fa', ':FZFAg<cr>',      silent = true, remap = false, desc = 'fzf: ag' },
        {
            '<leader>fA',
            function()
                local cword = vim.fn.expand('<cword>')
                vim.cmd(vim.g.fzf_command_prefix .. 'Ag ' .. cword .. '<cr>')
            end,
            silent = true,
            remap = false,
            desc = 'fzf: ag cword'
        },
        { '<leader>fh',       ':FZFHistory<cr>',    silent = true, remap = false,  desc = 'fzf: command history' },
        { '<leader>fw',       ':FZFWindows<cr>',    silent = true, remap = false,  desc = 'fzf: windows' },
        { '<leader>fc',       ':FZFCommands<cr>',   silent = true, remap = false,  desc = 'fzf: commands' },
        { '<leader>/',        ':FZFHistory/<cr>',   silent = true, remap = false,  desc = 'fzf: search history' },
        { '<leader>fT',       ':FZFTags<cr>',       silent = true, remap = false,  desc = 'fzf: ctags' },
        { '<leader>fm',       ':FZFMarks<cr>',      silent = true, remap = false,  desc = 'fzf: marks' },
        { '<leader>ft',       find_tag,             silent = true, remap = false,  desc = 'fzf: find buffer tag' },

        { '<leader><leader>', '<plug>(fzf-maps-n)', mode = 'n',    silent = false, remap = true,                 desc = 'fzf: nmap' },
        { '<leader><leader>', '<plug>(fzf-maps-o)', mode = 'o',    silent = false, remap = true,                 desc = 'fzf: omap' },
        { '<leader><leader>', '<plug>(fzf-maps-x)', mode = 'x',    silent = false, remap = true,                 desc = 'fzf: xmap' },
    },

}

local marks = {
    'tenfyzhong/fzf-marks.vim',
    dependencies = { fzf[1] },
    config = function()
        local group = vim.api.nvim_create_augroup('fzf_marks_local', {})
        vim.api.nvim_create_autocmd('User', {
            group = group,
            pattern = 'FZFMarksCd',
            callback = function()
                local cwd = vim.fn.getcwd()
                require('nvim-tree.api').tree.open { path = cwd }
            end,
        })
    end,
    keys = {
        { '<leader>fs', ':FZFFzm<cr>', silent = true, remap = false, desc = 'fzf-marks: marks' },
    },
    cmd = { 'FZFFzm' },
}

local bookmarks = {
    'tenfyzhong/fzf-bookmarks.vim',
    dependencies = { fzf[1] },
    config = function()
    end,
    keys = {
        { '<leader>fM', ':FZFBookmarks<cr>', silent = true, remap = false, desc = 'fzf-bookmarks: bookmarks' },
    },
    cmd = { 'FZFBookmarks' },
}

local z = {
    'tenfyzhong/z.nvim',
    dependencies = { fzf[1] },
    config = function()
        require('z').setup {}

        local group = vim.api.nvim_create_augroup('z_local', {})
        vim.api.nvim_create_autocmd('User', {
            group = group,
            pattern = 'Zcd',
            callback = function()
                local cwd = vim.fn.getcwd()
                require('nvim-tree.api').tree.open { path = cwd }
            end,
        })
    end,
    keys = {
        { '<leader>fz', ':FZFZ<cr>', silent = true, remap = false, desc = 'z: z' },
    },
    cmd = { 'FZFZ' },
}

return { fzf, fzf_vim, marks, bookmarks, z }
