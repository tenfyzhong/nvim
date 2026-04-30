-- GitHub Gist commands with nested editor support.

local unception = {
    "samjwill/nvim-unception",
    init = function()
        vim.g.unception_block_while_host_edits = true
    end,
}

local gist = {
    "Rawnly/gist.nvim",
    cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
    config = true,
    dependencies = { unception },
}

return { gist }
