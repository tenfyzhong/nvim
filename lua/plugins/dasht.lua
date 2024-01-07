local dasht = {
    'sunaku/vim-dasht',
    init = function()
        -- " create window below current one (default)
        -- let g:dasht_results_window = 'new'

        -- " create window beside current one
        -- let g:dasht_results_window = 'vnew'

        -- " use current window to show results
        -- let g:dasht_results_window = 'enew'

        -- " create panel at left-most edge
        -- let g:dasht_results_window = 'topleft vnew'

        -- " create panel at right-most edge
        -- let g:dasht_results_window = 'botright vnew'

        -- " create new tab beside current one
        -- let g:dasht_results_window = 'tabnew'
    end,
    config = function()
        vim.keymap.set('n', '<leader>ds', ':call Dasht(dasht#cursor_search_terms())<cr>',
            { silent = true, remap = false, desc = 'dasht: search cword' })
        vim.keymap.set('v', '<leader>ds', 'y:<C-U>call Dasht(getreg(0))<cr>',
            { silent = true, remap = false, desc = 'dasht: search selected text' })
    end,
    event = 'VeryLazy',
}

return { dasht }
