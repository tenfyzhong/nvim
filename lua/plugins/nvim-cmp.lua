--[[
- @file nvim-cmp.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-26 17:25:34
--]]

local function cmp_config()
    local cmp = require 'cmp'

    local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
    end

    local super_next = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
            feedkey("<Plug>(vsnip-expand-or-jump)", "")
            -- elseif has_words_before() then
            --     cmp.complete()
        else
            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
    end, { "i", "s" })

    local super_prev = cmp.mapping(function()
        if cmp.visible() then
            cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            feedkey("<Plug>(vsnip-jump-prev)", "")
        end
    end, { "i", "s" })

    local lspkind = require('lspkind')

    cmp.setup({
        enabled = function()
            -- disable completion in comments
            local context = require 'cmp.config.context'
            -- keep command mode completion enabled when cursor is in a comment
            if vim.api.nvim_get_mode().mode == 'c' then
                return true
            else
                return not context.in_treesitter_capture("comment")
                    and not context.in_syntax_group("Comment")
            end
        end,
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ['<c-n>'] = cmp.mapping.select_next_item(),
            ['<c-p>'] = cmp.mapping.select_prev_item(),
            ['<Tab>'] = super_next,
            ['<S-Tab>'] = super_prev,
            ['<c-j>'] = super_next,
            ['<c-k>'] = super_prev,
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lua' },
            { name = "git" },
            { name = 'vsnip' }, -- For vsnip users.
            { name = "codeium" },
            -- { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
        }, {
            { name = 'buffer' },
        }),
        formatting = {
            format = lspkind.cmp_format({
                mode = 'symbol',       -- show only symbol annotations
                maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

                -- The function below will be called before any actual modifications from lspkind
                -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                before = function(entry, vim_item)
                    -- ...
                    return vim_item
                end
            })
        },
        preselect = cmp.PreselectMode.None,
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
            { name = 'buffer' },
        })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })

    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
    )

    require("neodev").setup({})
end

local function lspkind_config()
    require('lspkind').init({
        -- DEPRECATED (use mode instead): enables text annotations
        --
        -- default: true
        -- with_text = true,

        -- defines how annotations are shown
        -- default: symbol
        -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
        mode = 'symbol_text',

        -- default symbol map
        -- can be either 'default' (requires nerd-fonts font) or
        -- 'codicons' for codicon preset (requires vscode-codicons font)
        --
        -- default: 'default'
        preset = 'codicons',

        -- override preset symbols
        --
        -- default: {}
        symbol_map = {
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "󰈇",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "",
        },
    })
end

local lspconfig = { 'neovim/nvim-lspconfig' }
local cmp_nvim_lsp = { 'hrsh7th/cmp-nvim-lsp' }
local cmp_buffer = { 'hrsh7th/cmp-buffer' }
local cmp_path = { 'hrsh7th/cmp-path' }
local cmp_cmdline = { 'hrsh7th/cmp-cmdline' }
local cmp_vsnip = { 'hrsh7th/cmp-vsnip' }
local vim_vsnip = { 'hrsh7th/vim-vsnip' }
local lspkind = { 'onsails/lspkind.nvim', config = lspkind_config }
local cmp_nvim_lua = { 'hrsh7th/cmp-nvim-lua' }
local tsnippets = { 'tenfyzhong/tsnippets.vim' }
local friendly_snippets = { 'rafamadriz/friendly-snippets' }
local cmp_nvim_lsp_signature_help = { 'hrsh7th/cmp-nvim-lsp-signature-help' }
local neodev = { 'folke/neodev.nvim', event = 'VeryLazy' }
local plenary = { 'nvim-lua/plenary.nvim' }
local cmp_git = { 'petertriho/cmp-git' }

local codeium = {
    "jcdickinson/codeium.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({
        })
    end
}

local nvim_cmp = {
    'hrsh7th/nvim-cmp',
    config = cmp_config,
    dependencies = {
        cmp_nvim_lsp,
        lspkind,
        cmp_cmdline,
        cmp_vsnip,
        vim_vsnip,
        cmp_nvim_lua,
        tsnippets,
        friendly_snippets,
        cmp_nvim_lsp_signature_help,
        cmp_git,
        cmp_path,
        cmp_buffer,
        codeium,
    },
}

return {
    cmp_nvim_lsp,
    lspconfig,
    lspkind,
    neodev,
    plenary,
    nvim_cmp,
    codeium,
}
