--[[
- @file vim-bookmarks.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 22:18:23
--]]

local bookmarks = {
    'MattesGroeger/vim-bookmarks',
    init = function()
        vim.g.bookmark_sign                    = ">"
        vim.g.bookmark_annotation_sign         = "$"
        vim.g.bookmark_no_default_key_mappings = 1
        vim.g.bookmark_save_per_working_dir    = 1
        vim.g.bookmark_auto_save               = 1
        vim.g.bookmark_disable_ctrlp           = 1
    end,
    config = function()
    end,
    cmd = {
        'BookmarkToggle',
        'BookmarkAnnotate',
        'BookmarkNext',
        'BookmarkPrev',
        'BookmarkShowAll',
        'BookmarkClear',
        'BookmarkClearAll',
        'BookmarkMoveUp',
        'BookmarkMoveDown',
        'BookmarkMoveToLine',
        'BookmarkSave',
        'BookmarkLoad',
    },
    keys = {
        { 'Mm', '<Plug>BookmarkToggle',   mode = 'n', silent = true, remap = true, desc = 'bookmarks: toogle a bookmark' },
        { 'Ma', '<Plug>BookmarkAnnotate', mode = 'n', silent = true, remap = true, desc = 'bookmarks: annotate a bookmark' },
        { 'Ms', '<Plug>BookmarkShowAll',  mode = 'n', silent = true, remap = true, desc = 'bookmarks: show all bookmarks' },
        { 'Mn', '<Plug>BookmarkNext',     mode = 'n', silent = true, remap = true, desc = 'bookmarks: goto next bookmark' },
        { 'Mp', '<Plug>BookmarkPrev',     mode = 'n', silent = true, remap = true, desc = 'bookmarks: goto prev bookmark' },
        { 'Mc', '<Plug>BookmarkClear',    mode = 'n', silent = true, remap = true, desc = 'bookmarks: clear bookmark' },
        { 'Mx', '<Plug>BookmarkClearAll', mode = 'n', silent = true, remap = true, desc = 'bookmarks: clear all bookmarks' },
        { 'Mu', '<Plug>BookmarkMoveUp',   mode = 'n', silent = true, remap = true, desc = 'bookmarks: bookmark move up' },
        { 'Md', '<Plug>BookmarkMoveDown', mode = 'n', silent = true, remap = true, desc = 'bookmarks: bookmark move down' },
    },

}

return { bookmarks }
