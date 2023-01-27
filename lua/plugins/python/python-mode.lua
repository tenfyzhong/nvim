--[[
- @file python-mode.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 13:50:12
--]]
local function config()
    vim.cmd([[
let g:pymode_paths = ['~/code/python']
let g:pymode_lint_ignore = "W391"
let g:pymode = 1
let g:pymode_folding = 1
let g:pymode_options = 1
let g:pymode_options_max_line_length = 80
let g:pymode_quickfix_minheight = 3
let g:pymode_quickfix_maxheight = 6
let g:pymode_indent = 1
let g:pymode_motion = 1
let g:pymode_doc = 1
let g:pymode_run = 1
let g:pymode_breakpoint = 1
let g:pymode_lint_on_write = 1
let g:pymode_lint_on_fly = 0
let g:pymode_lint_message = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
let g:pymode_trim_whitespaces = 1
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_regenerate_on_write = 0
let g:pymode_rope_completion = 0

let g:pymode_rope_goto_definition_bind = "<C-]>"
let g:pymode_run_bind = '<leader>rr'
let g:pymode_breakpoint_bind = '<leader>rb'
let g:pymode_rope_autoimport_bind = '<leader>ra'
let g:pymode_rope_goto_definition_bind = '<leader>rg'
let g:pymode_rope_show_doc_bind = '<leader>rd'
let g:pymode_rope_find_it_bind = '<leader>rf'
let g:pymode_rope_organize_imports_bind = '<leader>ro'
let g:pymode_rope_rename_bind = '<leader>re'
let g:pymode_rope_rename_module_bind = '<leader>r1m'
let g:pymode_rope_module_to_package_bind = '<leader>r1p'
let g:pymode_rope_extract_method_bind = '<leader>rm'
let g:pymode_rope_extract_variable_bind = '<leader>rl'
let g:pymode_rope_inline_bind = '<leader>ri'
let g:pymode_rope_move_bind = '<leader>rv'
let g:pymode_rope_generate_function_bind = '<leader>rnf'
let g:pymode_rope_generate_class_bind = '<leader>rnc'
let g:pymode_rope_generate_package_bind = '<leader>rnp'
let g:pymode_rope_change_signature_bind = '<leader>rs'
let g:pymode_rope_use_function_bind = '<leader>ru'

let g:pymode_virtualenv = 1
let g:pymode_virtualenv_path = $VIRTUAL_ENV

let g:pymode_rope_autoimport = 1
let g:pymode_rope_autoimport_import_after_complete = 0

let g:pymode_lint_options_pep8 =
    \ {'max_line_length': g:pymode_options_max_line_length}
let g:pymode_lint_options_pylint =
    \ {'max-line-length': g:pymode_options_max_line_length}
let g:pymode_rope = 1

augroup pymode_init
  autocmd FileType python nnoremap <buffer><silent><leader>qc :call <sid>close_doc_window()<cr>
augroup end

func! s:close_doc_window()
  " save cur pos
  let winid = win_getid()
  let cur_pos = getcurpos()

  let quick_loc_list = feature#GetQuickfixOrLoclistWinNr()
  let doc_bufnr = bufnr('__doc__')
  if doc_bufnr != -1
    let doc_winnr = bufwinnr(doc_bufnr)
    if doc_winnr != -1
      exec printf('%dclose', doc_winnr)
      return
    endif
  endif

  call feature#QuickfixDo('close')
endfunc
    ]])
end

local mode = {
    'python-mode/python-mode',
    config = config,
    ft = 'python',
}

return { mode }
