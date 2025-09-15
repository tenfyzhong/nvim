local bookmarks = {
    "tenfyzhong/bookmarks.nvim",
    config = function()
        local bm = require("bookmarks")
        bm.setup({})
        local map = vim.keymap.set
        map("n", "Mm", bm.bookmark_toggle) -- add or remove bookmark at current line
        map("n", "Ma", function()
            local word = vim.fn.expand("<cword>")
            bm.bookmark_ann(word)
        end) -- add or edit mark annotation at current line
        map("n", "Mc", bm.bookmark_clean) -- clean all marks in local buffer
        map("n", "Mn", bm.bookmark_next) -- jump to next mark in local buffer
        map("n", "Mp", bm.bookmark_prev) -- jump to previous mark in local buffer
        map("n", "Ms", bm.bookmark_list) -- show marked file list in quickfix window
        map("n", "Mx", bm.bookmark_clear_all) -- removes all bookmarks
    end,
    event = "VeryLazy",
}

return { bookmarks }
