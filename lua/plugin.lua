local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop
if not uv.fs_stat(lazypath) then
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
        }, true, {})
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {
    defaults = {
        lazy = false, -- should plugins be lazy-loaded?
        version = nil,
        -- version = "*", -- enable this to try installing the latest stable versions of plugins
    },
    dev = {
        -- directory where you store your local plugin projects
        path = "~/.config/nvim/lua/dev",
        ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
        patterns = { "tenfyzhong", "zhongtenghui" }, -- For example {"folke"}
        fallback = true, -- Fallback to git when local plugin doesn't exist
    },
    install = {
        -- install missing plugins on startup. This doesn't increase startup time.
        missing = true,
        -- try to load one of these colorschemes when starting an installation during startup
        colorscheme = { "catppuccin" },
    },
})
