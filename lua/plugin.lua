--[[
- @file plugin.lua
- @brief load all plugin in `plugins` directory
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-26 22:09:56
--]]

local config_path = vim.fn.stdpath('config')
local path = vim.fs.normalize(config_path .. '/lua/plugins/')
local files = {}
for f, t in vim.fs.dir(path) do
    if t == 'file' and string.sub(f, 1, 1) ~= '.' then
        table.insert(files, f)
    end
end

local plugins = {}
for _, f in ipairs(files) do
    local ps = dofile(path .. f)
    for _, p in ipairs(ps) do
        table.insert(plugins, p)
    end
end

-- for _, p in ipairs(plugins) do
--     p.pre()
-- end

return require('packer').startup(function(use)
    for _, p in ipairs(plugins) do
        use(p)
    end

    -- for _, p in ipairs(plugins) do
    --     p.post()
    -- end
end)
