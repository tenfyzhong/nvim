--[[
- @file lspsaga.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-02-07 20:50:17
--]]

local lspsaga = {
    'glepnir/lspsaga.nvim',
    branch = "main",
    config = function()
        require("lspsaga").setup({})

        local keymap = vim.keymap.set
        -- you can use <C-t> to jump back
        keymap("n", "gh", "<cmd>silent Lspsaga lsp_finder<CR>", { silent = true, remap = false })

        -- Code action
        keymap({ "n", "v" }, "<leader>la", "<cmd>silent Lspsaga code_action<CR>", { silent = true, remap = false })

        -- Rename all occurrences of the hovered word for the entire file
        keymap("n", "<leader>lr", "<cmd>silent Lspsaga rename<CR>", { silent = true, remap = false })

        -- Peek definition
        -- You can edit the file containing the definition in the floating window
        -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
        -- It also supports tagstack
        -- Use <C-t> to jump back
        keymap("n", "gD", "<cmd>silent Lspsaga peek_definition<CR>", { silent = true, remap = false })

        -- Go to definition
        keymap("n", "gd", "<cmd>silent Lspsaga goto_definition<CR>", { silent = true, remap = false })

        -- Show line diagnostics
        -- You can pass argument ++unfocus to
        -- unfocus the show_line_diagnostics floating window
        keymap("n", "<leader>ll", "<cmd>silent Lspsaga show_line_diagnostics<CR>", { silent = true, remap = false })

        -- Show cursor diagnostics
        -- Like show_line_diagnostics, it supports passing the ++unfocus argument
        keymap("n", "<leader>lc", "<cmd>silent Lspsaga show_cursor_diagnostics<CR>", { silent = true, remap = false })

        -- Show buffer diagnostics
        keymap("n", "<leader>lb", "<cmd>silent Lspsaga show_buf_diagnostics<CR>", { silent = true, remap = false })

        -- Diagnostic jump
        -- You can use <C-o> to jump back to your previous location
        keymap("n", "[e", "<cmd>silent Lspsaga diagnostic_jump_prev<CR>", { silent = true, remap = false })
        keymap("n", "]e", "<cmd>silent Lspsaga diagnostic_jump_next<CR>", { silent = true, remap = false })

        -- Diagnostic jump with filters such as only jumping to an error
        keymap("n", "[E", function()
            require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end, { silent = true, remap = false })
        keymap("n", "]E", function()
            require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
        end, { silent = true, remap = false })

        -- Toggle outline
        keymap("n", "<leader>lt", "<cmd>silent Lspsaga outline<CR>", { silent = true, remap = false })

        -- Hover Doc
        -- If there is no hover doc,
        -- there will be a notification stating that
        -- there is no information available.
        -- To disable it just use ":Lspsaga hover_doc ++quiet"
        -- Pressing the key twice will enter the hover window
        -- keymap("n", "K", "<cmd>silent Lspsaga hover_doc<CR>", { silent = true, remap = false })

        -- If you want to keep the hover window in the top right hand corner,
        -- you can pass the ++keep argument
        -- Note that if you use hover with ++keep, pressing this key again will
        -- close the hover window. If you want to jump to the hover window
        -- you should use the wincmd command "<C-w>w"
        keymap("n", "K", "<cmd>silent Lspsaga hover_doc ++keep<CR>", { silent = true, remap = false })

        -- Call hierarchy
        keymap("n", "<Leader>li", "<cmd>silent Lspsaga incoming_calls<CR>", { silent = true, remap = false })
        keymap("n", "<Leader>lo", "<cmd>silent Lspsaga outgoing_calls<CR>", { silent = true, remap = false })

        -- Floating terminal
        keymap({ "n", "t" }, "<A-d>", "<cmd>silent Lspsaga term_toggle<CR>", { silent = true, remap = false })
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } }
}

return { lspsaga }
