vim.cmd([[
  set background=dark
  highlight CursorLine term=underline cterm=NONE ctermbg=DarkGrey guibg=Grey90
  highlight ColorColumn ctermbg=DarkGrey guibg=Grey90
  highlight Folded term=bold cterm=bold ctermfg=12 ctermbg=0 guifg=Cyan guibg=DarkGrey
  hi MatchParen term=bold cterm=bold ctermfg=1 ctermbg=240 guibg=DarkCyan
  highlight! link SignColumn LineNr
]])
