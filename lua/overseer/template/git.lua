local overseer = require("overseer")

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
            cmd = { "git" },
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
local function get_git_root(opts)
    return vim.fs.find(".git", { upward = true, type = "directory", path = opts.dir })[1]
end

return {
    cache_key = function(opts)
        return get_git_root(opts)
    end,
    condition = {
        callback = function(opts)
            if vim.fn.executable("git") == 0 then
                return false, 'Command "go" not found'
            end
            if not get_git_root(opts) then
                return false, "No git root found"
            end
            return true
        end,
    },
    generator = function(opts, cb)
        local git_root = vim.fs.dirname(assert(get_git_root(opts)))
        local ret = {}

        local commands = {
            { args = { "pull" }, priority = 70 },
            { args = { "push" }, priority = 70 },
        }

        for _, command in ipairs(commands) do
            table.insert(
                ret,
                overseer.wrap_template(
                    tmpl,
                    {
                        name = string.format("git %s", table.concat(command.args, " ")),
                        tags = command.tags,
                        priority = command.priority or 60,
                    },
                    { args = command.args, cwd = git_root, }
                )
            )
        end
        cb(ret)
    end,
}
