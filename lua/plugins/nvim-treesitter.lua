-- Treesitter parsing, textobjects, and syntax-aware editing.

local function treesister_config()
    require("nvim-treesitter.configs").setup({
        matchup = {
            enable = true, -- mandatory, false will disable the whole extension
            -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
            -- [options]
        },
        -- A list of parser names, or "all" (the four listed parsers should always be installed)
        ensure_installed = {
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
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        -- List of parsers to ignore installing (for "all")
        -- ignore_install = { "javascript" },

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
            -- `false` will disable the whole extension
            enable = true,
            -- enable = { 'markdown', 'codecompanion' },

            -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
            -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
            -- the name of the parser)
            -- list of language that will be disabled
            -- disable = { "c", "rust" },
            -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
            disable = function(lang, buf)
                local ft = vim.bo[buf].filetype
                if ft ~= "markdown" and ft ~= "codecompanion" then
                    return true
                end

                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = { "markdown", "codecompanion" },
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                -- mappings for incremental selection (visual mappings)
                init_selection = "+", -- maps in normal mode to init the node/scope selection
                node_incremental = "+", -- increment to the upper named parent
                -- scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
                node_decremental = "-", -- decrement to the previous node
            },
        },
        textobjects = {
            select = {
                enable = true,

                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,

                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["af"] = { query = "@function.outer", desc = "Select a function" },
                    ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
                    ["aC"] = { query = "@class.outer", desc = "Select a class" },
                    ["iC"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                    ["ac"] = { query = "@conditional.outer", desc = "Select a conditional block" },
                    ["ic"] = { query = "@conditional.inner", desc = "Select a conditional inner block" },
                    ["ae"] = { query = "@block.outer", desc = "Select a block" },
                    ["ie"] = { query = "@block.inner", desc = "Select an inner block" },
                    ["al"] = { query = "@loop.outer", desc = "Select a loop" },
                    ["il"] = { query = "@loop.inner", desc = "Select an inner loop" },
                    ["as"] = { query = "@statement.outer", desc = "Select a statement" },
                    ["is"] = { query = "@statement.inner", desc = "Select an inner statement" },
                    ["ad"] = { query = "@comment.outer", desc = "Select a comment" },
                    ["am"] = { query = "@call.outer", desc = "Select a call" },
                    ["im"] = { query = "@call.inner", desc = "Select an inner call" },
                },
                -- You can choose the select mode (default is charwise 'v')
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * method: eg 'v' or 'o'
                -- and should return the mode ('v', 'V', or '<c-v>') or a table
                -- mapping query_strings to modes.
                selection_modes = {
                    ["@parameter.outer"] = "v",
                    ["@function.outer"] = "v",
                    ["@class.outer"] = "v",
                },
                -- If you set this to `true` (default is `false`) then any textobject is
                -- extended to include preceding or succeeding whitespace. Succeeding
                -- whitespace has priority in order to act similarly to eg the built-in
                -- `ap`.
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * selection_mode: eg 'v'
                -- and should return true or false
                include_surrounding_whitespace = true,
            },
            swap = {
                enable = true,
                swap_next = {
                    ["g>"] = { query = "@parameter.inner", desc = "Swap with the next parameter" },
                    ["gf"] = { query = "@function.outer", desc = "Swap with the next function" },
                },
                swap_previous = {
                    ["g<"] = { query = "@parameter.inner", desc = "Swap with the previous parameter" },
                    ["gF"] = { query = "@function.outer", desc = "Swap with the previous function" },
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]f"] = { query = "@function.outer", desc = "Move to start of the next function" },
                    ["]m"] = { query = "@function.outer", desc = "Move to start of the next function" },
                    ["]]"] = { query = "@class.outer", desc = "Move to start of the next class" },
                    --
                    -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                    -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                    ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Move to the next scope" },
                    ["]z"] = { query = "@fold", query_group = "folds", desc = "Move to the next fold" },

                    ["]d"] = { query = "@conditional.outer", desc = "Move to the next conditional" },
                },
                goto_next_end = {
                    ["]F"] = { query = "@function.outer", desc = "Move to end of the next function" },
                    ["]M"] = { query = "@function.outer", desc = "Move to end of the next function" },
                    ["]["] = { query = "@class.outer", desc = "Move the end of the next class" },
                },
                goto_previous_start = {
                    ["[f"] = { query = "@function.outer", desc = "Move to the start of the previous function" },
                    ["[m"] = { query = "@function.outer", desc = "Move to the start of the previous function" },
                    ["[["] = { query = "@class.outer", desc = "Move to the start of the previous class" },

                    ["[s"] = { query = "@local.scope", query_group = "locals", desc = "Move to the previous scope" },
                    ["[z"] = { query = "@fold", query_group = "folds", desc = "Move to start of the previous fold" },

                    ["[d"] = { query = "@conditional.outer", desc = "Move to start of the previous conditional" },
                },
                goto_previous_end = {
                    ["[F"] = { query = "@function.outer", desc = "Move to end of the previous function" },
                    ["[M"] = { query = "@function.outer", desc = "Move to end of the previous function" },
                    ["[]"] = { query = "@class.outer", desc = "Move to end of the previous function" },
                },
                -- Below will go to either the start or the end, whichever is closer.
                -- Use if you want more granular movements
                -- Make it even more gradual by adding multiple queries and regex.
                -- goto_next = {
                --     ["]d"] = "@conditional.outer",
                -- },
                -- goto_previous = {
                --     ["[d"] = "@conditional.outer",
                -- },
            },
            lsp_interop = {
                enable = true,
                border = "none",
                floating_preview_opts = {},
                peek_definition_code = {
                    ["<leader>df"] = "@function.outer",
                    ["<leader>dF"] = "@class.outer",
                },
            },
        },
    })
    -- vim.o.foldmethod = 'expr'
    -- vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
    -- vim.o.foldenable = false

    local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

    -- Repeat movement with ; and ,
    -- ensure ; goes forward and , goes backward regardless of the last direction
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, "<leader>,", ts_repeat_move.repeat_last_move_previous)

    -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

    -- make gitsigns.nvim movement repeatable with ; and , keys.
    local gs = require("gitsigns")

    -- make sure forward function comes first
    local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(function()
        if vim.wo.diff then
            return "]c"
        end
        vim.schedule(function()
            gs.next_hunk()
        end)
        return "<Ignore>"
    end, function()
        if vim.wo.diff then
            return "[c"
        end
        vim.schedule(function()
            gs.prev_hunk()
        end)
        return "<Ignore>"
    end)
    -- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.

    vim.keymap.set({ "n", "x", "o" }, "]h", next_hunk_repeat)
    vim.keymap.set({ "n", "x", "o" }, "[h", prev_hunk_repeat)
end

local context = {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
        require("treesitter-context").setup({
            on_attach = function(bufno)
                local ft = vim.bo[bufno].filetype
                return ft ~= "expect"
            end,
        })
    end,
    event = "VeryLazy",
}

local textobjects = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
}

local treesitter = {
    "nvim-treesitter/nvim-treesitter",
    config = treesister_config,
    event = "VeryLazy",
    dependencies = { context, textobjects },
}

return { treesitter }
