-- Custom type-casting text helpers on `<leader>ct`.

local typecase = {
    "tenfyzhong/typecast.vim",
    keys = {
        { "<leader>ct", mode = { "n", "x" } },
    },
}
return { typecase }
