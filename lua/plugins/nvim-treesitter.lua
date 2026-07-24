-- Treesitter parsing, textobjects, and syntax-aware editing.

local parsers = {
    "bash",
    "go",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "gomod",
    "gowork",
    "gosum",
    "fish",
    "sql",
    "json",
    "git_config",
    "git_rebase",
    "gitcommit",
    "gitignore",
    "markdown",
    "markdown_inline",
}

local function treesitter_config()
    local treesitter = require("nvim-treesitter")

    treesitter.setup({})
    treesitter.install(parsers)

    local highlight_group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        group = highlight_group,
        pattern = { "markdown", "codecompanion" },
        callback = function(args)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
            if ok and stats and stats.size > max_filesize then
                return
            end

            pcall(vim.treesitter.start, args.buf)
        end,
    })
end

local function textobjects_config()
    require("nvim-treesitter-textobjects").setup({
        select = {
            lookahead = true,
            selection_modes = {
                ["@parameter.outer"] = "v",
                ["@function.outer"] = "v",
                ["@class.outer"] = "v",
            },
            include_surrounding_whitespace = true,
        },
        move = {
            set_jumps = true,
        },
    })

    local function map_select(lhs, capture, desc)
        vim.keymap.set({ "x", "o" }, lhs, function()
            require("nvim-treesitter-textobjects.select").select_textobject(capture, "textobjects")
        end, { desc = desc })
    end

    map_select("af", "@function.outer", "Select a function")
    map_select("if", "@function.inner", "Select inner part of a function")
    map_select("aC", "@class.outer", "Select a class")
    map_select("iC", "@class.inner", "Select inner part of a class region")
    map_select("ac", "@conditional.outer", "Select a conditional block")
    map_select("ic", "@conditional.inner", "Select a conditional inner block")
    map_select("ae", "@block.outer", "Select a block")
    map_select("ie", "@block.inner", "Select an inner block")
    map_select("al", "@loop.outer", "Select a loop")
    map_select("il", "@loop.inner", "Select an inner loop")
    map_select("as", "@statement.outer", "Select a statement")
    map_select("is", "@statement.inner", "Select an inner statement")
    map_select("ad", "@comment.outer", "Select a comment")
    map_select("am", "@call.outer", "Select a call")
    map_select("im", "@call.inner", "Select an inner call")

    local function map_swap(lhs, method, capture, desc)
        vim.keymap.set("n", lhs, function()
            require("nvim-treesitter-textobjects.swap")[method](capture, "textobjects")
        end, { desc = desc })
    end

    map_swap("g>", "swap_next", "@parameter.inner", "Swap with the next parameter")
    map_swap("gf", "swap_next", "@function.outer", "Swap with the next function")
    map_swap("g<", "swap_previous", "@parameter.inner", "Swap with the previous parameter")
    map_swap("gF", "swap_previous", "@function.outer", "Swap with the previous function")

    local function map_move(lhs, method, capture, query_group, desc)
        vim.keymap.set({ "n", "x", "o" }, lhs, function()
            require("nvim-treesitter-textobjects.move")[method](capture, query_group)
        end, { desc = desc })
    end

    map_move("]f", "goto_next_start", "@function.outer", "textobjects", "Move to start of the next function")
    map_move("]m", "goto_next_start", "@function.outer", "textobjects", "Move to start of the next function")
    map_move("]]", "goto_next_start", "@class.outer", "textobjects", "Move to start of the next class")
    map_move("]s", "goto_next_start", "@local.scope", "locals", "Move to the next scope")
    map_move("]z", "goto_next_start", "@fold", "folds", "Move to the next fold")
    map_move("]d", "goto_next_start", "@conditional.outer", "textobjects", "Move to the next conditional")
    map_move("]F", "goto_next_end", "@function.outer", "textobjects", "Move to end of the next function")
    map_move("]M", "goto_next_end", "@function.outer", "textobjects", "Move to end of the next function")
    map_move("][", "goto_next_end", "@class.outer", "textobjects", "Move to end of the next class")
    map_move("[f", "goto_previous_start", "@function.outer", "textobjects", "Move to start of the previous function")
    map_move("[m", "goto_previous_start", "@function.outer", "textobjects", "Move to start of the previous function")
    map_move("[[", "goto_previous_start", "@class.outer", "textobjects", "Move to start of the previous class")
    map_move("[s", "goto_previous_start", "@local.scope", "locals", "Move to the previous scope")
    map_move("[z", "goto_previous_start", "@fold", "folds", "Move to the previous fold")
    map_move("[d", "goto_previous_start", "@conditional.outer", "textobjects", "Move to the previous conditional")
    map_move("[F", "goto_previous_end", "@function.outer", "textobjects", "Move to end of the previous function")
    map_move("[M", "goto_previous_end", "@function.outer", "textobjects", "Move to end of the previous function")
    map_move("[]", "goto_previous_end", "@class.outer", "textobjects", "Move to end of the previous class")

    local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, "<leader>,", ts_repeat_move.repeat_last_move_previous)
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

    local hunk_move = ts_repeat_move.make_repeatable_move(function(opts)
        if vim.wo.diff then
            vim.cmd.normal({ args = { opts.forward and "]c" or "[c" }, bang = true })
            return
        end

        vim.schedule(function()
            require("gitsigns").nav_hunk(opts.forward and "next" or "prev")
        end)
    end)

    vim.keymap.set({ "n", "x", "o" }, "]h", function()
        hunk_move({ forward = true })
    end, { desc = "Move to the next Git hunk" })
    vim.keymap.set({ "n", "x", "o" }, "[h", function()
        hunk_move({ forward = false })
    end, { desc = "Move to the previous Git hunk" })
end

local context = {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
        on_attach = function(bufnr)
            return vim.bo[bufnr].filetype ~= "expect"
        end,
    },
}

local textobjects = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    config = textobjects_config,
}

local treesitter = {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = treesitter_config,
    dependencies = { context, textobjects },
}

return { treesitter }
