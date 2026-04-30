-- XML syntax and filetype support.

local xml = {
    "othree/xml.vim",
    ft = "xml",
    config = function()
        vim.g.xml_syntax_folding = 1
    end,
}

return { xml }
