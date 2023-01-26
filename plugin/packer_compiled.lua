-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/bytedance/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/bytedance/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/bytedance/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/bytedance/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/bytedance/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["aerial.nvim"] = {
    config = { "\27LJ\2\np\0\0\6\0\a\0\t6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\nremap\1\27:call aerial#fzf()<cr>\15<leader>ft\6n\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/aerial.nvim",
    url = "https://github.com/stevearc/aerial.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-git"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/cmp-git",
    url = "https://github.com/petertriho/cmp-git"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["lspkind.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["neodev.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/neodev.nvim",
    url = "https://github.com/folke/neodev.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nî\1\0\0\b\0\t\2'6\0\0\0\14\0\0\0X\1\2€6\0\1\0009\0\0\0007\0\0\0006\0\0\0006\2\2\0009\2\3\0029\2\4\2)\4\0\0B\2\2\0A\0\0\3\b\1\0\0X\2\20€6\2\2\0009\2\3\0029\2\5\2)\4\0\0\23\5\1\0\18\6\0\0+\a\2\0B\2\5\2:\2\1\2\18\4\2\0009\2\6\2\18\5\1\0\18\6\1\0B\2\4\2\18\4\2\0009\2\a\2'\5\b\0B\2\3\2\n\2\0\0X\2\2€+\2\1\0X\3\1€+\2\2\0L\2\2\0\a%s\nmatch\bsub\23nvim_buf_get_lines\24nvim_win_get_cursor\bapi\bvim\ntable\vunpack\0\2p\0\2\n\0\4\0\0156\2\0\0009\2\1\0029\2\2\0026\4\0\0009\4\1\0049\4\3\4\18\6\0\0+\a\2\0+\b\2\0+\t\2\0B\4\5\2\18\5\1\0+\6\2\0B\2\4\1K\0\1\0\27nvim_replace_termcodes\18nvim_feedkeys\bapi\bvimå\1\0\1\5\3\b\1 -\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4€-\1\0\0009\1\1\1B\1\1\1X\1\22€6\1\2\0009\1\3\0019\1\4\1)\3\1\0B\1\2\2\t\1\0\0X\1\5€-\1\1\0'\3\5\0'\4\6\0B\1\3\1X\1\n€-\1\2\0B\1\1\2\15\0\1\0X\2\4€-\1\0\0009\1\a\1B\1\1\1X\1\2€\18\1\0\0B\1\1\1K\0\1\0\0À\2À\1À\rcomplete\5!<Plug>(vsnip-expand-or-jump)\20vsnip#available\afn\bvim\21select_next_item\fvisible\2¨\1\0\0\4\2\a\1\21-\0\0\0009\0\0\0B\0\1\2\15\0\0\0X\1\4€-\0\0\0009\0\1\0B\0\1\1X\0\v€6\0\2\0009\0\3\0009\0\4\0)\2ÿÿB\0\2\2\t\0\0\0X\0\4€-\0\1\0'\2\5\0'\3\6\0B\0\3\1K\0\1\0\0À\2À\5\28<Plug>(vsnip-jump-prev)\19vsnip#jumpable\afn\bvim\21select_prev_item\fvisible\2å\1\0\0\4\0\v\0\0286\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1B\1\1\0029\1\5\1\a\1\6\0X\1\3€+\1\2\0L\1\2\0X\1\14€9\1\a\0'\3\b\0B\1\2\2\14\0\1\0X\1\5€9\1\t\0'\3\n\0B\1\2\2\19\1\1\0X\2\3€+\1\1\0X\2\1€+\1\2\0L\1\2\0K\0\1\0\fComment\20in_syntax_group\fcomment\26in_treesitter_capture\6c\tmode\18nvim_get_mode\bapi\bvim\23cmp.config.context\frequire;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvim\v\0\2\2\0\0\0\1L\1\2\0A\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1À\24nvim_buf_set_keymap\bapi\bvimA\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1À\24nvim_buf_set_option\bapi\bvimI\1\2\b\0\4\0\b3\2\0\0003\3\1\0\18\4\3\0'\6\2\0'\a\3\0B\4\3\0012\0\0€K\0\1\0\27v:lua.vim.lsp.omnifunc\romnifunc\0\0ÿ\15\1\0\19\0x\0ç\0016\0\0\0'\2\1\0B\0\2\0023\1\2\0003\2\3\0009\3\4\0003\5\5\0005\6\6\0B\3\3\0029\4\4\0003\6\a\0005\a\b\0B\4\3\0026\5\0\0'\a\t\0B\5\2\0029\6\n\0005\b\f\0003\t\v\0=\t\r\b5\t\15\0003\n\14\0=\n\16\t=\t\17\b4\t\0\0=\t\18\b9\t\4\0009\t\19\t9\t\20\t5\v\22\0009\f\4\0009\f\21\f)\14üÿB\f\2\2=\f\23\v9\f\4\0009\f\21\f)\14\4\0B\f\2\2=\f\24\v9\f\4\0009\f\25\fB\f\1\2=\f\26\v9\f\4\0009\f\27\fB\f\1\2=\f\28\v9\f\4\0009\f\29\f5\14\30\0B\f\2\2=\f\31\v9\f\4\0009\f \fB\f\1\2=\f!\v9\f\4\0009\f\"\fB\f\1\2=\f#\v=\3$\v=\4%\v=\3&\v=\4'\vB\t\2\2=\t\4\b9\t(\0009\t)\t4\v\6\0005\f*\0>\f\1\v5\f+\0>\f\2\v5\f,\0>\f\3\v5\f-\0>\f\4\v5\f.\0>\f\5\v4\f\3\0005\r/\0>\r\1\fB\t\3\2=\t)\b5\t4\0009\n0\0055\f1\0003\r2\0=\r3\fB\n\2\2=\n5\t=\t6\bB\6\2\0019\6\n\0009\0067\6'\b8\0005\t;\0009\n(\0009\n)\n4\f\3\0005\r9\0>\r\1\f4\r\3\0005\14:\0>\14\1\rB\n\3\2=\n)\tB\6\3\0019\6\n\0009\6<\0065\b=\0005\t>\0009\n\4\0009\n\19\n9\n<\nB\n\1\2=\n\4\t4\n\3\0005\v?\0>\v\1\n=\n)\tB\6\3\0019\6\n\0009\6<\6'\b@\0005\tA\0009\n\4\0009\n\19\n9\n<\nB\n\1\2=\n\4\t9\n(\0009\n)\n4\f\3\0005\rB\0>\r\1\f4\r\3\0005\14C\0>\14\1\rB\n\3\2=\n)\tB\6\3\0016\6\0\0'\bD\0B\6\2\0029\6\n\0064\b\0\0B\6\2\0013\6E\0006\a\0\0'\tF\0B\a\2\0026\b\0\0'\nG\0B\b\2\0029\bH\bB\b\1\0029\tI\a9\t\n\t5\vJ\0=\bK\v5\fL\0=\fM\v5\fQ\0005\rO\0005\14N\0=\14P\r=\rI\f=\fR\v=\6S\vB\t\2\0019\tT\a9\t\n\t5\vi\0005\fg\0005\rV\0005\14U\0=\14W\r5\14Y\0005\15X\0=\15Z\14=\14[\r5\14`\0006\15\\\0009\15]\0159\15^\15'\17_\0+\18\2\0B\15\3\2=\15a\14=\14b\r5\14c\0=\14d\r5\14e\0=\14f\r=\rh\f=\fR\vB\t\2\0019\tj\a9\t\n\t4\v\0\0B\t\2\0019\tk\a9\t\n\t5\vt\0005\fs\0005\rq\0005\14o\0005\15m\0005\16l\0=\16n\15=\15p\14=\14r\r=\rk\f=\fR\vB\t\2\0019\tu\a9\t\n\t4\v\0\0B\t\2\0019\tv\a9\t\n\t4\v\0\0B\t\2\0019\tw\a9\t\n\t4\v\0\0B\t\2\0012\0\0€K\0\1\0\vjsonls\vbashls\nbufls\1\0\0\1\0\0\fplugins\1\0\0\16pycodestyle\1\0\0\vignore\1\0\1\18maxLineLength\3d\1\2\0\0\tW391\npylsp\nvimls\1\0\0\bLua\1\0\0\15completion\1\0\1\16callSnippet\fReplace\14telemetry\1\0\1\venable\1\14workspace\flibrary\1\0\0\5\26nvim_get_runtime_file\bapi\bvim\16diagnostics\fglobals\1\0\0\1\2\0\0\bvim\fruntime\1\0\0\1\0\1\fversion\vLuaJIT\16sumneko_lua\14on_attach\rsettings\1\0\0\ranalyses\1\0\4\20usePlaceholders\2\16staticcheck\2\fgofumpt\2#experimentalPostfixCompletions\2\1\0\4\17unusedparams\2\fnilness\2\vuseany\2\16unusedwrite\2\bcmd\1\2\0\0\ngopls\17capabilities\1\0\0\ngopls\25default_capabilities\17cmp_nvim_lsp\14lspconfig\0\vneodev\1\0\1\tname\fcmdline\1\0\1\tname\tpath\1\0\0\6:\1\0\1\tname\vbuffer\1\0\0\1\3\0\0\6/\6?\fcmdline\1\0\0\1\0\1\tname\vbuffer\1\0\1\tname\fcmp_git\14gitcommit\rfiletype\15formatting\vformat\1\0\0\vbefore\0\1\0\3\18ellipsis_char\b...\rmaxwidth\0032\tmode\vsymbol\15cmp_format\1\0\1\tname\vbuffer\1\0\1\tname\nvsnip\1\0\1\tname\bgit\1\0\1\tname\rnvim_lua\1\0\1\tname\28nvim_lsp_signature_help\1\0\1\tname\rnvim_lsp\fsources\vconfig\n<c-k>\n<c-j>\f<S-Tab>\n<Tab>\n<c-p>\21select_prev_item\n<c-n>\21select_next_item\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nabort\14<C-Space>\rcomplete\n<C-f>\n<C-b>\1\0\0\16scroll_docs\vinsert\vpreset\vwindow\fsnippet\vexpand\1\0\0\0\fenabled\1\0\0\0\nsetup\flspkind\1\3\0\0\6i\6s\0\1\3\0\0\6i\6s\0\fmapping\0\0\bcmp\frequire\0" },
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["tsnippets.vim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/tsnippets.vim",
    url = "https://github.com/tenfyzhong/tsnippets.vim"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nî\1\0\0\b\0\t\2'6\0\0\0\14\0\0\0X\1\2€6\0\1\0009\0\0\0007\0\0\0006\0\0\0006\2\2\0009\2\3\0029\2\4\2)\4\0\0B\2\2\0A\0\0\3\b\1\0\0X\2\20€6\2\2\0009\2\3\0029\2\5\2)\4\0\0\23\5\1\0\18\6\0\0+\a\2\0B\2\5\2:\2\1\2\18\4\2\0009\2\6\2\18\5\1\0\18\6\1\0B\2\4\2\18\4\2\0009\2\a\2'\5\b\0B\2\3\2\n\2\0\0X\2\2€+\2\1\0X\3\1€+\2\2\0L\2\2\0\a%s\nmatch\bsub\23nvim_buf_get_lines\24nvim_win_get_cursor\bapi\bvim\ntable\vunpack\0\2p\0\2\n\0\4\0\0156\2\0\0009\2\1\0029\2\2\0026\4\0\0009\4\1\0049\4\3\4\18\6\0\0+\a\2\0+\b\2\0+\t\2\0B\4\5\2\18\5\1\0+\6\2\0B\2\4\1K\0\1\0\27nvim_replace_termcodes\18nvim_feedkeys\bapi\bvimå\1\0\1\5\3\b\1 -\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4€-\1\0\0009\1\1\1B\1\1\1X\1\22€6\1\2\0009\1\3\0019\1\4\1)\3\1\0B\1\2\2\t\1\0\0X\1\5€-\1\1\0'\3\5\0'\4\6\0B\1\3\1X\1\n€-\1\2\0B\1\1\2\15\0\1\0X\2\4€-\1\0\0009\1\a\1B\1\1\1X\1\2€\18\1\0\0B\1\1\1K\0\1\0\0À\2À\1À\rcomplete\5!<Plug>(vsnip-expand-or-jump)\20vsnip#available\afn\bvim\21select_next_item\fvisible\2¨\1\0\0\4\2\a\1\21-\0\0\0009\0\0\0B\0\1\2\15\0\0\0X\1\4€-\0\0\0009\0\1\0B\0\1\1X\0\v€6\0\2\0009\0\3\0009\0\4\0)\2ÿÿB\0\2\2\t\0\0\0X\0\4€-\0\1\0'\2\5\0'\3\6\0B\0\3\1K\0\1\0\0À\2À\5\28<Plug>(vsnip-jump-prev)\19vsnip#jumpable\afn\bvim\21select_prev_item\fvisible\2å\1\0\0\4\0\v\0\0286\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1B\1\1\0029\1\5\1\a\1\6\0X\1\3€+\1\2\0L\1\2\0X\1\14€9\1\a\0'\3\b\0B\1\2\2\14\0\1\0X\1\5€9\1\t\0'\3\n\0B\1\2\2\19\1\1\0X\2\3€+\1\1\0X\2\1€+\1\2\0L\1\2\0K\0\1\0\fComment\20in_syntax_group\fcomment\26in_treesitter_capture\6c\tmode\18nvim_get_mode\bapi\bvim\23cmp.config.context\frequire;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvim\v\0\2\2\0\0\0\1L\1\2\0A\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1À\24nvim_buf_set_keymap\bapi\bvimA\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1À\24nvim_buf_set_option\bapi\bvimI\1\2\b\0\4\0\b3\2\0\0003\3\1\0\18\4\3\0'\6\2\0'\a\3\0B\4\3\0012\0\0€K\0\1\0\27v:lua.vim.lsp.omnifunc\romnifunc\0\0ÿ\15\1\0\19\0x\0ç\0016\0\0\0'\2\1\0B\0\2\0023\1\2\0003\2\3\0009\3\4\0003\5\5\0005\6\6\0B\3\3\0029\4\4\0003\6\a\0005\a\b\0B\4\3\0026\5\0\0'\a\t\0B\5\2\0029\6\n\0005\b\f\0003\t\v\0=\t\r\b5\t\15\0003\n\14\0=\n\16\t=\t\17\b4\t\0\0=\t\18\b9\t\4\0009\t\19\t9\t\20\t5\v\22\0009\f\4\0009\f\21\f)\14üÿB\f\2\2=\f\23\v9\f\4\0009\f\21\f)\14\4\0B\f\2\2=\f\24\v9\f\4\0009\f\25\fB\f\1\2=\f\26\v9\f\4\0009\f\27\fB\f\1\2=\f\28\v9\f\4\0009\f\29\f5\14\30\0B\f\2\2=\f\31\v9\f\4\0009\f \fB\f\1\2=\f!\v9\f\4\0009\f\"\fB\f\1\2=\f#\v=\3$\v=\4%\v=\3&\v=\4'\vB\t\2\2=\t\4\b9\t(\0009\t)\t4\v\6\0005\f*\0>\f\1\v5\f+\0>\f\2\v5\f,\0>\f\3\v5\f-\0>\f\4\v5\f.\0>\f\5\v4\f\3\0005\r/\0>\r\1\fB\t\3\2=\t)\b5\t4\0009\n0\0055\f1\0003\r2\0=\r3\fB\n\2\2=\n5\t=\t6\bB\6\2\0019\6\n\0009\0067\6'\b8\0005\t;\0009\n(\0009\n)\n4\f\3\0005\r9\0>\r\1\f4\r\3\0005\14:\0>\14\1\rB\n\3\2=\n)\tB\6\3\0019\6\n\0009\6<\0065\b=\0005\t>\0009\n\4\0009\n\19\n9\n<\nB\n\1\2=\n\4\t4\n\3\0005\v?\0>\v\1\n=\n)\tB\6\3\0019\6\n\0009\6<\6'\b@\0005\tA\0009\n\4\0009\n\19\n9\n<\nB\n\1\2=\n\4\t9\n(\0009\n)\n4\f\3\0005\rB\0>\r\1\f4\r\3\0005\14C\0>\14\1\rB\n\3\2=\n)\tB\6\3\0016\6\0\0'\bD\0B\6\2\0029\6\n\0064\b\0\0B\6\2\0013\6E\0006\a\0\0'\tF\0B\a\2\0026\b\0\0'\nG\0B\b\2\0029\bH\bB\b\1\0029\tI\a9\t\n\t5\vJ\0=\bK\v5\fL\0=\fM\v5\fQ\0005\rO\0005\14N\0=\14P\r=\rI\f=\fR\v=\6S\vB\t\2\0019\tT\a9\t\n\t5\vi\0005\fg\0005\rV\0005\14U\0=\14W\r5\14Y\0005\15X\0=\15Z\14=\14[\r5\14`\0006\15\\\0009\15]\0159\15^\15'\17_\0+\18\2\0B\15\3\2=\15a\14=\14b\r5\14c\0=\14d\r5\14e\0=\14f\r=\rh\f=\fR\vB\t\2\0019\tj\a9\t\n\t4\v\0\0B\t\2\0019\tk\a9\t\n\t5\vt\0005\fs\0005\rq\0005\14o\0005\15m\0005\16l\0=\16n\15=\15p\14=\14r\r=\rk\f=\fR\vB\t\2\0019\tu\a9\t\n\t4\v\0\0B\t\2\0019\tv\a9\t\n\t4\v\0\0B\t\2\0019\tw\a9\t\n\t4\v\0\0B\t\2\0012\0\0€K\0\1\0\vjsonls\vbashls\nbufls\1\0\0\1\0\0\fplugins\1\0\0\16pycodestyle\1\0\0\vignore\1\0\1\18maxLineLength\3d\1\2\0\0\tW391\npylsp\nvimls\1\0\0\bLua\1\0\0\15completion\1\0\1\16callSnippet\fReplace\14telemetry\1\0\1\venable\1\14workspace\flibrary\1\0\0\5\26nvim_get_runtime_file\bapi\bvim\16diagnostics\fglobals\1\0\0\1\2\0\0\bvim\fruntime\1\0\0\1\0\1\fversion\vLuaJIT\16sumneko_lua\14on_attach\rsettings\1\0\0\ranalyses\1\0\4\20usePlaceholders\2\16staticcheck\2\fgofumpt\2#experimentalPostfixCompletions\2\1\0\4\17unusedparams\2\fnilness\2\vuseany\2\16unusedwrite\2\bcmd\1\2\0\0\ngopls\17capabilities\1\0\0\ngopls\25default_capabilities\17cmp_nvim_lsp\14lspconfig\0\vneodev\1\0\1\tname\fcmdline\1\0\1\tname\tpath\1\0\0\6:\1\0\1\tname\vbuffer\1\0\0\1\3\0\0\6/\6?\fcmdline\1\0\0\1\0\1\tname\vbuffer\1\0\1\tname\fcmp_git\14gitcommit\rfiletype\15formatting\vformat\1\0\0\vbefore\0\1\0\3\18ellipsis_char\b...\rmaxwidth\0032\tmode\vsymbol\15cmp_format\1\0\1\tname\vbuffer\1\0\1\tname\nvsnip\1\0\1\tname\bgit\1\0\1\tname\rnvim_lua\1\0\1\tname\28nvim_lsp_signature_help\1\0\1\tname\rnvim_lsp\fsources\vconfig\n<c-k>\n<c-j>\f<S-Tab>\n<Tab>\n<c-p>\21select_prev_item\n<c-n>\21select_next_item\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nabort\14<C-Space>\rcomplete\n<C-f>\n<C-b>\1\0\0\16scroll_docs\vinsert\vpreset\vwindow\fsnippet\vexpand\1\0\0\0\fenabled\1\0\0\0\nsetup\flspkind\1\3\0\0\6i\6s\0\1\3\0\0\6i\6s\0\fmapping\0\0\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: aerial.nvim
time([[Config for aerial.nvim]], true)
try_loadstring("\27LJ\2\np\0\0\6\0\a\0\t6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\nremap\1\27:call aerial#fzf()<cr>\15<leader>ft\6n\bset\vkeymap\bvim\0", "config", "aerial.nvim")
time([[Config for aerial.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
