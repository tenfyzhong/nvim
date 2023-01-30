--[[
- @file defx.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 08:54:10
--]]
function DefxFiletypeAutocmd()
    vim.wo.wrap = false
    vim.keymap.set('n', 'i', '<NOP>', { silent = true, buffer = true })
    vim.keymap.set('n', 'I', '<NOP>', { silent = true, buffer = true })
    vim.keymap.set('n', 'c', '<NOP>', { silent = true, buffer = true })
    vim.keymap.set('n', 'C', '<NOP>', { silent = true, buffer = true })
    vim.keymap.set('n', 'S', '<NOP>', { silent = true, buffer = true })
    vim.keymap.set('n', 'a', '<NOP>', { silent = true, buffer = true })
    vim.keymap.set('n', 'A', '<NOP>', { silent = true, buffer = true })
    vim.keymap.set('n', 'O', '<NOP>', { silent = true, buffer = true })
    vim.keymap.set('n', 'yy', 'defx#do_action("copy")', { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', 'dd', 'defx#do_action("move")', { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', '<c-v>', 'defx#do_action("paste")', { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', 'p', "defx#do_action('search', fnamemodify(defx#get_candidate().action__path, ':h'))",
        { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', 'l', 'defx#is_directory() ? defx#do_action("open") : "\\<Ignore>"',
        { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', 'v',
        '!defx#is_directory() && !defx#is_binary() ? defx#do_action("drop", "vsplit") : "\\<Ignore>"',
        { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', 's',
        '!defx#is_directory() && !defx#is_binary() ? defx#do_action("drop", "split") : "\\<Ignore>"',
        { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', '<cr>',
        'defx#is_directory() ? defx#do_action("open_tree", "toggle") : !defx#is_binary() ? defx#do_action("drop") : "\\<Ignore>"'
        , { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', 'o', '<cr>', { silent = true, remap = true, buffer = true })
    vim.keymap.set('n', 'mk', 'defx#do_action("new_directory")',
        { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', 'mf', 'defx#do_action("new_file")', { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', 'mm', 'defx#do_action("new_multiple_files")', { silent = true, remap = false, expr = true,
        buffer = true })
    vim.keymap.set('n', 'rm', 'defx#do_action("remove")', { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', 'rn', 'defx#do_action("rename")', { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', '!', 'defx#do_action("execute_command")',
        { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', '.', 'defx#do_action("repeat")', { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', 'h', 'defx#do_action("cd", [".."])', { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', '~', 'defx#do_action("cd")', { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', 'q', 'defx#do_action("quit")', { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', '<space><space>', 'defx#do_action("toggle_select")j',
        { silent = true, remap = true, expr = true, buffer = true })
    vim.keymap.set('n', '*', 'defx#do_action("toggle_select_all")',
        { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', 'j', 'line(".") == line("$") ? "gg" : "j"',
        { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', 'k', 'line(".") == 1 ? "G" : "k"',
        { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', '<c-r>', 'defx#do_action("redraw")', { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', '<c-g>', 'defx#do_action("print")', { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', 'cd', 'defx#do_action("change_vim_cwd")',
        { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', '>', 'defx#do_action("resize", defx#get_context().winwidth+2)',
        { silent = true, remap = false, expr = true, buffer = true })
    vim.keymap.set('n', '<', 'defx#do_action("resize", defx#get_context().winwidth-2)',
        { silent = true, remap = false, expr = true, buffer = true })
end

local function defx_config()
    vim.g.defx_icons_column_length = 2
    vim.keymap.set('n', '<leader>nt', function() require('feature').DefxCwd() end, { silent = true, remap = false })
    local group = vim.api.nvim_create_augroup('defx_init', {})
    vim.api.nvim_create_autocmd({ 'FileType' }, {
        group = group,
        pattern = { 'defx' },
        callback = DefxFiletypeAutocmd,
    })

    vim.cmd([[
function! DefxRoot(path)
  let root = system('git rev-parse --show-toplevel 2> /dev/null')
  let root = substitute(root, '\n', '', '')
  let project = fnamemodify(root, ':t')
  if root != ''
    return fnamemodify(a:path, ':p:s?'.root.'?$/'.project.'?:~')
  else
    return fnamemodify(a:path, ':p:~')
  endif
endfunction

call defx#custom#source('file', {
      \ 'root': 'DefxRoot',
      \ })

call defx#custom#column('indent', 'indent', ' ')
call defx#custom#column('time', 'format', '%y-%m-%d %H:%M')
" call defx#custom#column('space', '')

call defx#custom#column('icon', {
      \ 'directory_icon': '▸ ',
      \ 'file_icon': '  ',
      \ 'opened_icon': '▾ ',
      \ 'root_icon': '  ',
      \ })

call defx#custom#column('mark', {
      \ 'readonly_icon': '✗',
      \ 'selected_icon': '✓',
      \ 'length': 0,
      \ })

call defx#custom#option('_', {
      \ 'winwidth': 30,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'toggle': 1,
      \ 'resume': 1,
      \ 'columns': 'git:indent:icons:filename',
	  \ 'root_marker': '',
      \ 'ignored_files': '.*,*.a,*.so,*.o,*.d,*.swp,*.bak,*~,tags,cscope.*,*.pyc',
      \ 'auto_cd': 1,
      \ })

call defx#custom#column('filename', {
      \ 'root_marker_highlight': 'Ignore',
      \ })

call defx#custom#column('git', 'indicators', {
  \ 'Modified'  : '✹',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?'
  \ })

call defx#custom#column('git', 'column_length', 1)
        ]])
end

function DefxGitFiletypeAutocmd()
    vim.keymap.set('n', '[c', '<Plug>(defx-git-prev)', { silent = true, remap = false, buffer = true })
    vim.keymap.set('n', ']c', '<Plug>(defx-git-next)', { silent = true, remap = false, buffer = true })
    vim.keymap.set('n', ']a', '<Plug>(defx-git-stage)', { silent = true, remap = false, buffer = true })
    vim.keymap.set('n', ']r', '<Plug>(defx-git-reset)', { silent = true, remap = false, buffer = true })
    vim.keymap.set('n', ']d', '<Plug>(defx-git-discard)', { silent = true, remap = false, buffer = true })
end

local function defx_git_config()
    local group = vim.api.nvim_create_augroup('defx_git_init', {})
    vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = { 'defx' },
        callback = DefxGitFiletypeAutocmd,
    })
end

local defx = { 'Shougo/defx.nvim', config = defx_config, cmd = 'Defx', keys = '<leader>nt' }
local defx_git = { 'kristijanhusak/defx-git', config = defx_git_config, requires = defx[1] }
local defx_icons = { 'kristijanhusak/defx-icons', requires = defx[1] }

return { defx, defx_git, defx_icons }
