--[[
- @file vim-bookmarks.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 22:18:23
--]]

local bookmarks = {
    'MattesGroeger/vim-bookmarks',
    config = function()
        vim.g.bookmark_sign                    = ">"
        vim.g.bookmark_annotation_sign         = "$"
        vim.g.bookmark_no_default_key_mappings = 1
        vim.g.bookmark_save_per_working_dir    = 1
        vim.g.bookmark_auto_save               = 1
        vim.g.bookmark_disable_ctrlp           = 1

        vim.keymap.set('n', 'Mm', '<Plug>BookmarkToggle', { silent = true, remap = true })
        vim.keymap.set('n', 'Ma', '<Plug>BookmarkAnnotate', { silent = true, remap = true })
        vim.keymap.set('n', 'Ms', '<Plug>BookmarkShowAll', { silent = true, remap = true })
        vim.keymap.set('n', 'Mn', '<Plug>BookmarkNext', { silent = true, remap = true })
        vim.keymap.set('n', 'Mp', '<Plug>BookmarkPrev', { silent = true, remap = true })
        vim.keymap.set('n', 'Mc', '<Plug>BookmarkClear', { silent = true, remap = true })
        vim.keymap.set('n', 'Mx', '<Plug>BookmarkClearAll', { silent = true, remap = true })
        vim.keymap.set('n', 'Mu', '<Plug>BookmarkMoveUp', { silent = true, remap = true })
        vim.keymap.set('n', 'Md', '<Plug>BookmarkMoveDown', { silent = true, remap = true })
    end,
    cmd = { 'BookmarkToggle', 'BookmarkAnnotate', 'BookmarkNext', 'BookmarkPrev', 'BookmarkShowAll', 'BookmarkClear',
        'BookmarkClearAll', 'BookmarkMoveUp', 'BookmarkMoveDown', 'BookmarkMoveToLine', 'BookmarkSave', 'BookmarkLoad' },
    keys = { 'Mm', 'Ma', 'Ms', 'Mn', 'Mp', 'Mc', 'Mx', 'Mu', 'Md' },
}


return { bookmarks }
