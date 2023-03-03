--[[
- @file plugin.lua
- @brief load all plugin in `plugins` directory
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-26 22:09:56
--]]
--

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)
require('lazy').setup('plugins', {
    defaults = {
        lazy = false, -- should plugins be lazy-loaded?
        version = nil,
        -- version = "*", -- enable this to try installing the latest stable versions of plugins
    },
    dev = {
        -- directory where you store your local plugin projects
        path = "~/nvim-plugins",
        ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
        patterns = { 'tenfyzhong' }, -- For example {"folke"}
        fallback = true, -- Fallback to git when local plugin doesn't exist
    },
    install = {
        -- install missing plugins on startup. This doesn't increase startup time.
        missing = true,
        -- try to load one of these colorschemes when starting an installation during startup
        colorscheme = { "solarized" },
    }
})
