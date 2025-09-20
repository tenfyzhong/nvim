local matchup = {
    "andymass/vim-matchup",
    init = function()
        -- may set any options here
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
    -- event = 'VeryLazy',
}

return { matchup }
