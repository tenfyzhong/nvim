-- Find git root directory and add to workspace folders
local function find_git_root_and_add()
    -- Find git root directory
    local git_root = vim.fn.system('git rev-parse --show-toplevel 2>/dev/null'):gsub('\n', '')

    vim.g.augment_workspace_folders = { git_root }
end

local augment = {
    'augmentcode/augment.vim',
    init = function()
        -- vim.g.augment_workspace_folders = { '~/go/src/github.com/pingcap/ticdc' }
    end,
    config = function()
        -- vim.g.augment_disable_tab_mapping = true
        -- Keymaps for Augment
        vim.keymap.set('n', '<leader>aa', ':Augment<CR>', { desc = 'Open Augment' })
        vim.keymap.set('n', '<leader>ac', ':Augment chat<CR>', { desc = 'Augment Chat' })
        vim.keymap.set('v', '<leader>ac', ':Augment chat<CR>', { desc = 'Augment Chat with selection' })
        vim.keymap.set('i', '<c-l>', '<cmd>call augment#Accept()<cr>', { desc = 'Accpet Augment suggestion' })

        local augment_user = vim.api.nvim_create_augroup('augment_user', {})
        vim.api.nvim_create_autocmd("VimEnter", {
            group = augment_user,
            callback = find_git_root_and_add,
            desc = "Add git root to Augment workspace folders"
        })
    end,
    -- event = 'VeryLazy',
}

return { augment }
