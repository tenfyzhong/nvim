-- Join arguments or list items intelligently.

local conjoin = {
    "flwyd/vim-conjoin",
    cmd = { "Join" },
    keys = {
        { "J", mode = { "n", "x" } },
        { "gJ", mode = { "n", "x" } },
    },
}

return { conjoin }
