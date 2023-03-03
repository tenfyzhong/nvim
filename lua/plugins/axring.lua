--[[
- @file axring.lua
- @brief  
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 20:23:16
--]]

local axring = {
    'tenfyzhong/axring.vim',
    config = function()
        vim.g.axring_rings = {
            { '&&', '||' },
            { '&', '|', '^' },
            { '&=', '|=', '^=' },
            { '>>', '<<' },
            { '>>=', '<<=' },
            { '==', '!=' },
            { '>', '<', '>=', '<=' },
            { '++', '--' },
            { 'true', 'false' },
            { 'yes', 'no' },
            { 'on', 'off' },
            { 'and', 'or' },
            { "up", "down" },
            { "min", "max" },
            { "get", "set" },
            { "add", "remove" },
            { "to", "from" },
            { "read", "write" },
            { "only", "except" },
            { 'without', 'with' },
            { "exclude", "include" },
            { "asc", "desc" },
            { 'sunday', 'monday', 'tuesday', 'wednesday', 'thursday',
                'friday', 'saturday' },
            { 'january', 'february', 'march', 'april', 'may', 'june', 'july',
                'august', 'september', 'october', 'november', 'december' },
            { "in", "out" },
            { 'verbose', 'debug', 'info', 'warn', 'error', 'fatal' },
            { 'long', 'short' },
        }

        vim.g.axring_rings_c = {
            { 'if', 'else' },
            { 'ifdef', 'ifndef' },
            { 'uint8_t', 'uint16_t', 'uint32_t', 'uint64_t' },
            { 'int8_t', 'int16_t', 'int32_t', 'int64_t' },
        }

        vim.g.axring_rings_cpp = {
            { 'if', 'else' },
            { 'ifdef', 'ifndef' },
            { 'uint8_t', 'uint16_t', 'uint32_t', 'uint64_t' },
            { 'int8_t', 'int16_t', 'int32_t', 'int64_t' },
            { 'private', 'protected', 'public' },
            { 'class', 'struct' },
        }

        vim.g.axring_rings_python = {
            { 'if', 'elif', 'else' },
        }

        vim.g.axring_rings_go = {
            { ':=', '=' },
            { 'byte', 'rune' },
            { 'complex64', 'complex128' },
            { 'int', 'int8', 'int16', 'int32', 'int64' },
            { 'uint', 'uint8', 'uint16', 'uint32', 'uint64' },
            { 'float32', 'float64' },
            { 'interface', 'struct' },
            { 'const', 'var' },
        }

        vim.g.axring_rings_vim = {
            { 'if', 'elseif', 'else', 'endif' },
        }

        vim.g.axring_rings_sh = {
            { 'if', 'elif', 'else', 'fi' },
        }

        vim.g.axring_rings_css = {
            { "none", "block" },
            { "show", "hide" },
            { "left", "right" },
            { "top", "bottom" },
            { "margin", "padding" },
            { "before", "after" },
            { "absolute", "relative" },
            { "first", "last" },
        }

        vim.g.axring_rings_gitrebase = {
            { 'p', 'r', 'e', 's', 'f', 'x', 'd' },
            { 'pick', 'reword', 'edit', 'squash', 'fixup', 'exec', 'drop' },
        }

        vim.g.axring_rings_nginx = {
            { "debug", "info", "notice", "warn", "error", "crit", "alert", "emerg" },
            { "ip_hash", "fair", "url_hash", "least_conn", "hash" },
        }

        vim.g.axring_rings_thrift = {
            { "i16", "i32", "i64" },
            { "required", "optional" },
        }

        vim.g.axring_rings_proto = {
            { "int32", "int64" }
        }

        vim.g.axring_rings_gitcommit = {
            { "feat", "fix", "doc", "chore", "perf", "refactor", "test" }
        }

        vim.g.axring_rings_d2 = {
            {
                "rectangle",
                "square",
                "page",
                "parallelogram",
                "document",
                "cylinder",
                "queue",
                "package",
                "step",
                "callout",
                "stored_data",
                "person",
                "diamond",
                "oval",
                "circle",
                "hexagon",
                "cloud",
                "text",
                "code",
                "class",
                "sql_table",
                "image"
            },
        }
    end,
    event = 'VeryLazy',
}

return { axring }
