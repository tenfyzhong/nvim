--[[
- @file fzf.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 20:06:26
--]]

if vim.fn.isdirectory('~/.fzf/plugin') then
    vim.opt.rtp:append('~/.fzf')
elseif vim.fn.isdirectory('/usr/local/opt/fzf/plugin') then
    vim.opt.rtp:append('/usr/local/opt/fzf/plugin')
end

local fzf = {
    'junegunn/fzf.vim',
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

        vim.cmd([[
augroup fzf_local
  autocmd!
  autocmd User FZFMarksCd Defx -buffer-name=`'defx' . tabpagenr()`
  autocmd FileType thrift nnoremap <silent><buffer><leader>ft :FZFBTags<cr>
augroup END
        ]])
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

return { fzf, marks, bookmarks }
