--[[
- @file material.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2024-04-12 22:56:30
--]]

local material = {
    'marko-cerovac/material.nvim',
    init = function()
        vim.g.material_style = "palenight"
    end,
    config = function()
        local colors = require 'material.colors'
        require('material').setup({

            contrast = {
                terminal = false,            -- Enable contrast for the built-in terminal
                sidebars = false,            -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
                floating_windows = false,    -- Enable contrast for floating windows
                cursor_line = false,         -- Enable darker background for the cursor line
                lsp_virtual_text = false,    -- Enable contrasted background for lsp virtual text
                non_current_windows = false, -- Enable contrasted background for non-current windows
                filetypes = {},              -- Specify which filetypes get the contrasted (darker) background
            },

            styles = { -- Give comments style such as bold, italic, underline etc.
                comments = { --[[italic = true ]] },
                strings = { --[[ bold = true ]] },
                keywords = { --[[ underline = true ]] },
                functions = { --[[ bold = true, undercurl = true ]] },
                variables = {},
                operators = {},
                types = {},
            },

            plugins = { -- Uncomment the plugins that you use to highlight them
                -- Available plugins:
                -- "coc"
                "dap",
                -- "dashboard",
                -- "eyeliner",
                "fidget",
                -- "flash",
                "gitsigns",
                -- "harpoon",
                "hop",
                "illuminate",
                -- "indent-blankline",
                "lspsaga",
                -- "mini",
                "neogit",
                -- "neotest",
                -- "neo-tree",
                -- "neorg",
                -- "noice",
                "nvim-cmp",
                -- "nvim-navic",
                "nvim-tree",
                "nvim-web-devicons",
                -- "rainbow-delimiters",
                -- "sneak",
                "telescope",
                -- "trouble",
                -- "which-key",
                "nvim-notify",
            },

            disable = {
                colored_cursor = false, -- Disable the colored cursor
                borders = false,        -- Disable borders between verticaly split windows
                background = false,     -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
                term_colors = false,    -- Prevent the theme from setting terminal colors
                eob_lines = false       -- Hide the end-of-buffer lines
            },

            high_visibility = {
                lighter = false, -- Enable higher contrast text for lighter style
                darker = false   -- Enable higher contrast text for darker style
            },

            lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

            async_loading = true,      -- Load parts of the theme asyncronously for faster startup (turned on by default)

            custom_colors = nil,       -- If you want to override the default colors, set this to a function

            custom_highlights = {
                Folded = { bg = '#4F4E4E' },
                Visual = { bg = "#066378" },
                CurSearch = { bg = '#2970CC' },
                IncSearch = { bg = '#1D477D' },
                Search = { bg = '#1D477D' },
                Cursor = { bg = '#F0F0F0' },
                IlluminatedWordText = { bg = '#5E67A5' },
                LineNr = { fg = '#2e5343' }
            }, -- Overwrite highlights with your own
        })
    end,
}

return { material }
