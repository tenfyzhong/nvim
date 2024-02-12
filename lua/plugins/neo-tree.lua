local tree = {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        require('neo-tree').setup {
            use_default_mappings = true,
            close_if_last_window = true,
            filesystem = {
                filtered_items = {
                    show_hidden_count = false, -- when true, the number of hidden items in each folder will be shown as the last entry
                },
            },
            event_handlers = {
                {
                    event = "neo_tree_buffer_enter",
                    handler = function(arg)
                        vim.opt.relativenumber = true
                    end,
                }
            },
            window = {
                mapping_options = {
                    noremap = true,
                },
                mappings = {
                    ["S"] = "noop",
                    ["/"] = "noop",
                    ["s"] = { command = 'open_split' },
                    ["v"] = { command = 'open_vsplit' },
                    ["<esc>"] = {
                        "cancel",
                        nowait = true,
                    },
                },
            },
        }
    end,
    cmd = { 'Neotree' },
    keys = {
        { '<leader>nt', function() require('neo-tree.command').execute({ toggle = true, }) end, mode = { 'n' }, remap = false, desc = 'Neotree toggle=true' },
    },
}

return { tree }
