local constants = require("overseer.constants")
local overseer = require("overseer")
local TAG = constants.TAG

---@type overseer.TemplateFileDefinition
local tmpl = {
    priority = 60,
    params = {
        args = { type = "list", delimiter = " " },
        cwd = { optional = true },
        relative_file_root = {
            desc = "Relative filepaths will be joined to this root (instead of task cwd)",
            optional = true,
        },
    },
    builder = function(params)
        return {
            cmd = { "go" },
            args = params.args,
            cwd = params.cwd,
            --default_component_params = {
            --    errorformat = [[%Eerror: %\%%(aborting %\|could not compile%\)%\@!%m,]]
            --        .. [[%Eerror[E%n]: %m,]]
            --        .. [[%Inote: %m,]]
            --        .. [[%Wwarning: %\%%(%.%# warning%\)%\@!%m,]]
            --        .. [[%C %#--> %f:%l:%c,]]
            --        .. [[%E  left:%m,%C right:%m %f:%l:%c,%Z,]]
            --        .. [[%.%#panicked at \'%m\'\, %f:%l:%c]],
            --    relative_file_root = params.relative_file_root,
            --},
        }
    end,
}

---@param opts overseer.SearchParams
---@return nil|string
local function get_go_file(opts)
    return vim.fs.find("go.mod", { upward = true, type = "file", path = opts.dir })[1]
end

-- get current line go package
--@return string
local function cur_line_go_pkg()
    local line = vim.fn.line('.')
    local content = vim.fn.getline(line)
    local pkg = string.match(content, '"(.*)"')
    return pkg
end

return {
    cache_key = function(opts)
        return get_go_file(opts)
    end,
    condition = {
        callback = function(opts)
            if vim.fn.executable("go") == 0 then
                return false, 'Command "go" not found'
            end
            if not get_go_file(opts) then
                return false, "No go.mod file found"
            end
            return true
        end,
    },
    generator = function(opts, cb)
        local go_dir = vim.fs.dirname(assert(get_go_file(opts)))
        local ret = {}

        local commands = {
            { args = { "build" },      tags = { TAG.BUILD } },
            { args = { "test" },       tags = { TAG.TEST } },
            { args = { "clean" } },
            { args = { "run" } },
            { args = { "install" } },
            { args = { "mod", "tidy" } },
            { args = { "get", "." } },
        }
        local pkg = cur_line_go_pkg()
        if pkg then
            table.insert(commands, { args = { "get", pkg } })
        end

        for _, command in ipairs(commands) do
            table.insert(
                ret,
                overseer.wrap_template(
                    tmpl,
                    {
                        name = string.format("go %s", table.concat(command.args, " ")),
                        tags = command.tags,
                        priority = 55,
                    },
                    { args = command.args, cwd = go_dir, }
                )
            )
        end
        cb(ret)
    end,
}
