--[[
- @file bigfile.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2024-10-11 20:50:05
--]]




local bigfile = {
    'LunarVim/bigfile.nvim',
    config = function()
        require("bigfile").setup({
            -- detect long python files
            pattern = function(bufnr, filesize_mib)
                -- you can't use `nvim_buf_line_count` because this runs on BufReadPre
                local file_contents = vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr))
                local file_length = #file_contents
                local filetype = vim.filetype.match({ buf = bufnr })
                if file_length > 2000 and filetype == "thrift" then
                    return true
                end
                return false
            end,
            features = { -- features to disable
                -- "indent_blankline",
                -- "illuminate",
                -- "lsp",
                -- "treesitter",
                "syntax",
                -- "matchparen",
                -- "vimopts",
                -- "filetype",
            },
        })
    end,
    enable = false,
}

return { bigfile }
