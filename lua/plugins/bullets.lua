-- Smarter bullet and checkbox editing for markup files.

local bullets = {
    "dkarter/bullets.vim",
    config = function()
        vim.cmd([[
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \]

let g:bullets_checkbox_markers = ' x'
let g:bullets_renumber_on_change = 0
            ]])
    end,
    ft = { "markdown", "text", "gitcommit" },
}

return { bullets }
