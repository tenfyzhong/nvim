--[[
- @file opt.lua
- @brief global options
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-26 22:09:41
--]]

vim.opt.clipboard:append { 'unnamedplus' }

-- if (vim.o.shell != 'fish')
-- then
-- end

vim.o.directory = '.'
vim.o.compatible = false -- 关闭vi兼容模式
vim.o.cindent = true
vim.opt.cinoptions:append { ':0', 'l1', 'g0', 'N-s', '(0', 'w1', 'W4', 'j1', 'J1' }
-- vim.o.foldmethod = 'syntax'
vim.o.foldlevelstart = 99
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'
vim.opt.fileencodings = { 'utf-8', 'gbk', 'gb2312', 'cp936', 'usc-bom', 'euc-jp', 'gb18030' }
vim.o.mouse = ''
vim.o.wrapmargin = 0
vim.o.textwidth = 79
vim.o.colorcolumn = 120
vim.o.backspace = 2
-- vim.o
-- vim.opt.whichwrap:append{'<', '>', 'h', 'l'} TODO ERROR
vim.o.formatoptions = 'tcrqn'
vim.o.autowrite = true
vim.o.scrolloff = 2
vim.o.shortmess = 'atI'
vim.o.autoread = true
vim.o.cmdheight = 1
vim.o.hidden = true
vim.o.showmatch = false
vim.o.ruler = true
vim.o.showmode = false
vim.o.confirm = true
vim.o.hisearch = true
vim.o.incsearch = true
vim.o.wildmenu = true
vim.o.history = 500
vim.o.cursorline = true
vim.o.t_Co = 256
vim.o.tabshop = 4
vim.o.shiftwidth = 4
vim.o.softtabshop = 4
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.showtabline = 0
vim.o.laststatus = 2
vim.o.number = true
vim.o.relativenumber = true
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert' }
vim.o.splitright = true
vim.opt.diffopt = { 'filler', 'vertical' }
vim.opt.viminfo:append { '!' }
vim.o.belloff = 'all'
vim.o.errorbells = false
vim.o.visualbell = false
vim.o.t_vb = ''
-- vim.opt.shortmess:append{'c'} TODO
vim.opt.sessionoptions:remove { 'buffers' }

-- vim.o.syntax = 'on'
-- vim.o.syntax
vim.o.background = 'dark'
