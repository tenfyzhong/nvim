--[[
- @file plugin.lua
- @brief load all plugin in `plugins` directory
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-26 22:09:56
--]]

local function plugin_files(path, files)
    for f, t in vim.fs.dir(path) do
        local new = path .. f
        if t == 'directory' then
            plugin_files(new .. '/', files)
        elseif f:sub(1, 1) ~= '.' and f:sub(-3) == 'lua' then
            table.insert(files, new)
        end
    end
end

local config_path = vim.fn.stdpath('config')
local path = vim.fs.normalize(config_path .. '/lua/plugins/')

local files = {}
plugin_files(path, files)

local plugins = {}
for _, f in ipairs(files) do
    local ps = dofile(f)
    if ps ~= nil then
        for _, p in ipairs(ps) do
            -- if type(p) == 'string' then
            --     print(p)
            -- elseif type(p) == 'table' then
            --     print(p[1])
            -- end
            table.insert(plugins, p)
        end
    end
end

return require('packer').startup(function(use)
    for _, p in ipairs(plugins) do
        use(p)
    end
end)
