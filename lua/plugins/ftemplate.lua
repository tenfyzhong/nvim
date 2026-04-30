-- File template insertion for new buffers.

local ftemplate = {
    "tenfyzhong/ftemplate.vim",
    init = function()
        vim.g.ftemplate_local_templates = "~/.config/nvim/local/ftemplates"
        vim.g.ftemplate_ignore_ft = { "lua" }
    end,
    config = function() end,
}

return { ftemplate }
