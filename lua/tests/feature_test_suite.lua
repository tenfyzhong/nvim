lu = require("luaunit")

-- Test helper to mock _G.vim environment
local function setup_mock_vim()
    _G.vim = _G.vim or {}
    _G.vim.o = _G.vim.o or {}
    _G.vim.b = _G.vim.b or {}
    _G.vim.cmd = function() end
    _G.vim.api = _G.vim.api or {}
    _G.vim.api.nvim_get_current_buf = function()
        return 1
    end
    _G.vim.api.nvim_buf_get_name = function()
        return "test.txt"
    end
    _G.vim.api.nvim_buf_set_lines = function() end
    _G.vim.fn = _G.vim.fn or {}
    _G.vim.fn.win_findbuf = function()
        return {}
    end
    _G.vim.fn.win_execute = function() end
    _G.vim.fn.system = function()
        return 0
    end
    _G.vim.o.mod = false
    _G.vim.o.binary = false
    _G.vim.o.lazyredraw = false
    _G.vim.uv = _G.vim.uv or {}
    _G.vim.uv.fs_stat = function(path)
        return { size = 100 }
    end
end

local feature = require("feature")

function TestParseArgs()
    lu.assertEquals(feature.parse_args({}), {})
    lu.assertEquals(feature.parse_args(""), {})
    lu.assertEquals(feature.parse_args('arg1 "quoted arg" arg3'), { "arg1", "quoted arg", "arg3" })
    lu.assertEquals(feature.parse_args("arg1 'quoted arg' arg3"), { "arg1", "quoted arg", "arg3" })
    lu.assertEquals(feature.parse_args('arg1 "quoted \\"arg\\"" arg3'), { "arg1", 'quoted "arg"', "arg3" })
    lu.assertEquals(feature.parse_args("arg1 'quoted \\'arg\\'' arg3"), { "arg1", "quoted 'arg'", "arg3" })
    lu.assertEquals(feature.parse_args('arg1 "arg with spaces"'), { "arg1", "arg with spaces" })
    lu.assertEquals(
        feature.parse_args("  leading_space 'quoted with spaces' trailing_space  "),
        { "leading_space", "quoted with spaces", "trailing_space" }
    )
    lu.assertEquals(feature.parse_args('single_arg_with_quotes "test"'), { "single_arg_with_quotes", "test" })
    lu.assertEquals(feature.parse_args('""'), { "" })
    lu.assertEquals(feature.parse_args("''"), { "" })
    lu.assertEquals(feature.parse_args('" "'), { " " })
    lu.assertEquals(feature.parse_args("' '"), { " " })
    lu.assertEquals(feature.parse_args('arg1 "multi word" arg2'), { "arg1", "multi word", "arg2" })
    lu.assertEquals(feature.parse_args('arg1 "multi word"   arg2'), { "arg1", "multi word", "arg2" })
    lu.assertEquals(
        feature.parse_args('arg1 "multi word with \\"escaped quote\\"" arg2'),
        { "arg1", 'multi word with "escaped quote"', "arg2" }
    )
    lu.assertEquals(
        feature.parse_args("arg1 'multi word with \\'escaped quote\\'' arg2"),
        { "arg1", "multi word with 'escaped quote'", "arg2" }
    )
    lu.assertEquals(feature.parse_args("arg1\\ with\\ spaces"), { "arg1\\", "with\\", "spaces" }) -- Note: The current parse_args doesn't handle unquoted escaped spaces as a single argument. This is acceptable for now.
    lu.assertEquals(
        feature.parse_args("arg1\\ with\\ spaces 'quoted arg'"),
        { "arg1\\", "with\\", "spaces", "quoted arg" }
    )
    lu.assertEquals(feature.parse_args("arg1 'arg2' arg3"), { "arg1", "arg2", "arg3" })
    lu.assertEquals(feature.parse_args("arg1 'arg2 with spaces' arg3"), { "arg1", "arg2 with spaces", "arg3" })
    lu.assertEquals(
        feature.parse_args("arg1 'arg2 with \\'escaped\\' quotes' arg3"),
        { "arg1", "arg2 with 'escaped' quotes", "arg3" }
    )
    lu.assertEquals(
        feature.parse_args('arg1 "arg2 with \\"escaped\\" quotes" arg3'),
        { "arg1", 'arg2 with "escaped" quotes', "arg3" }
    )
    lu.assertEquals(
        feature.parse_args('arg1 "arg2 with \\\\backslashes" arg3'),
        { "arg1", "arg2 with \\backslashes", "arg3" }
    )
    lu.assertEquals(
        feature.parse_args("arg1 'arg2 with \\\\backslashes' arg3"),
        { "arg1", "arg2 with \\backslashes", "arg3" }
    )
end

function TestParseArgsEdgeCases()
    -- Edge case tests for parse_args
    lu.assertEquals(feature.parse_args(""), {}, "Empty string returns empty table")
    lu.assertEquals(feature.parse_args("   "), {}, "Whitespace-only returns empty table")
    lu.assertEquals(feature.parse_args("\t\n  "), {}, "Mixed whitespace returns empty table")
    lu.assertEquals(feature.parse_args("a   b   c"), { "a", "b", "c" }, "Multiple spaces between args")
    lu.assertEquals(feature.parse_args("a\tb\tc"), { "a", "b", "c" }, "Tabs as separators")
    lu.assertEquals(feature.parse_args('"a"b"c"'), { "a", "bc" }, "Concatenated quoted chars")
    lu.assertEquals(feature.parse_args('a"b"c'), { "ab", "c" }, "Mixed quoted and unquoted")
    lu.assertEquals(feature.parse_args("a'bc"), { "abc" }, "Unclosed single quote continues")
    lu.assertEquals(feature.parse_args("a\"b'c"), { "ab'c" }, "Unclosed double quote continues")
    lu.assertEquals(feature.parse_args('""'), { "" }, "Empty double quotes")
    lu.assertEquals(feature.parse_args("''"), { "" }, "Empty single quotes")
    lu.assertEquals(feature.parse_args('"  "'), { "  " }, "Quoted spaces")
    lu.assertEquals(feature.parse_args("'  '"), { "  " }, "Single quoted spaces")
    lu.assertEquals(feature.parse_args('"a\\nb"'), { "anb" }, "Escape n (not newline)")
    lu.assertEquals(feature.parse_args('"a\\tb"'), { "atb" }, "Escape t (not tab)")
    lu.assertEquals(feature.parse_args("a\\ b"), { "a\\", "b" }, "Unquoted backslash space doesn't escape")
    lu.assertEquals(feature.parse_args('"a\\\\"b'), { "a\\", "b" }, "Multiple backslashes before quote")
end

function TestGetRelativePath()
    -- Identical paths
    lu.assertEquals(feature.get_relative_path("/a/b/c", "/a/b/c"), ".")
    lu.assertEquals(feature.get_relative_path("a/b/c", "a/b/c"), ".")

    -- Target is deeper
    lu.assertEquals(feature.get_relative_path("/a/b/c/d", "/a/b/c"), "d")
    lu.assertEquals(feature.get_relative_path("a/b/c/d", "a/b/c"), "d")

    -- Base is deeper
    lu.assertEquals(feature.get_relative_path("/a/b/c", "/a/b/c/d"), "..")
    lu.assertEquals(feature.get_relative_path("a/b/c", "a/b/c/d"), "..")

    -- Sibling paths
    lu.assertEquals(feature.get_relative_path("/a/b/c", "/a/b/d"), "../c")
    lu.assertEquals(feature.get_relative_path("a/b/c", "a/b/d"), "../c")

    -- Complex paths
    lu.assertEquals(feature.get_relative_path("/a/b/c/d", "/a/x/y/z"), "../../../b/c/d")
    lu.assertEquals(feature.get_relative_path("a/b/c/d", "a/x/y/z"), "../../../b/c/d")

    -- Paths with '..' and '.'
    lu.assertEquals(feature.get_relative_path("/a/b/../c", "/a/d"), "../c")
    lu.assertEquals(feature.get_relative_path("/a/b/c", "/a/b/c/d/.."), ".")
    lu.assertEquals(feature.get_relative_path("/a/b/./c", "/a/b/c"), ".")
    lu.assertEquals(feature.get_relative_path("a/../b", "b"), ".")

    -- Mixed absolute and relative
    lu.assertEquals(feature.get_relative_path("/a/b", "c/d"), "/a/b")
    lu.assertEquals(feature.get_relative_path("a/b", "/c/d"), "a/b")

    -- Root paths
    lu.assertEquals(feature.get_relative_path("/a", "/"), "a")
    lu.assertEquals(feature.get_relative_path("/", "/a"), "..")
    lu.assertEquals(feature.get_relative_path("/", "/"), ".")

    -- Relative paths with no common root
    lu.assertEquals(feature.get_relative_path("a/b", "c/d"), "../../a/b")

    -- Empty paths
    lu.assertEquals(feature.get_relative_path("a", ""), "a")
    lu.assertEquals(feature.get_relative_path("", "a"), "..")
    lu.assertEquals(feature.get_relative_path("", ""), ".")
end

function TestGetRelativePathEdgeCases()
    -- Edge cases for get_relative_path
    -- Trailing slashes
    lu.assertEquals(feature.get_relative_path("/a/b/c/", "/a/b/"), "c", "Trailing slash on target")
    lu.assertEquals(feature.get_relative_path("/a/b/c", "/a/b/c/"), ".", "Trailing slash on base")
    lu.assertEquals(feature.get_relative_path("/a/b/c/", "/a/b/c/"), ".", "Both trailing slashes")

    -- Multiple slashes (empty components)
    lu.assertEquals(feature.get_relative_path("/a//b/c", "/a/b"), "c", "Double slash in target")
    lu.assertEquals(feature.get_relative_path("/a/b", "/a//b/c"), "..", "Double slash in base")

    -- Paths with dots in the middle
    lu.assertEquals(feature.get_relative_path("/a/./b/c", "/a/b"), "c", "Dot in middle of target")
    lu.assertEquals(feature.get_relative_path("/a/b", "/a/./b/c"), "..", "Dot in middle of base")
    lu.assertEquals(feature.get_relative_path("/a/b/../c", "/a/d"), "../c", "Parent dir in middle of target")

    -- Complex relative paths
    lu.assertEquals(feature.get_relative_path("../../a/b", "c/d"), "../../../../a/b", "Multiple parent dirs")
    lu.assertEquals(feature.get_relative_path("a/b/../c", "a/b"), "../c", "Parent dir resolves to sibling")

    -- Root edge cases
    lu.assertEquals(feature.get_relative_path("/", "/a"), "..", "Root to child")
    lu.assertEquals(feature.get_relative_path("/a", "/"), "a", "Child to root")
    lu.assertEquals(feature.get_relative_path("/", "/"), ".", "Root to root")

    -- Mixed absolute/relative (should return original)
    lu.assertEquals(feature.get_relative_path("/a/b", "c/d"), "/a/b", "Mixed abs/rel - abs target")
    lu.assertEquals(feature.get_relative_path("a/b", "/c/d"), "a/b", "Mixed abs/rel - rel target")
end

function TestToList()
    -- Test with string input
    lu.assertEquals(feature.to_list("hello"), { "hello" })
    lu.assertEquals(feature.to_list(""), { "" })

    -- Test with table input
    lu.assertEquals(feature.to_list({ "a", "b" }), { "a", "b" })
    lu.assertEquals(feature.to_list({}), {})
    local t = { 1, 2, 3 }
    lu.assertEquals(feature.to_list(t), t) -- Should return the same table reference

    -- Test with function returning a string
    local func_str = function()
        return "function_string"
    end
    lu.assertEquals(feature.to_list(func_str), { "function_string" })

    -- Test with function returning a table
    local func_table = function()
        return { "func", "table" }
    end
    lu.assertEquals(feature.to_list(func_table), { "func", "table" })

    -- Test with function returning nil
    local func_nil = function()
        return nil
    end
    lu.assertEquals(feature.to_list(func_nil), {})

    -- Test with nil input
    lu.assertEquals(feature.to_list(nil), {})

    -- Test with boolean input (should return empty table as it's not string, table, or function)
    lu.assertEquals(feature.to_list(true), {})
    lu.assertEquals(feature.to_list(false), {})

    -- Test with number input (should return empty table)
    lu.assertEquals(feature.to_list(123), {})

    -- Test with function that errors (should return empty table)
    local func_error = function()
        error("This function errors")
    end
    lu.assertEquals(feature.to_list(func_error), {})

    -- Edge case tests for to_list
    -- Function returning function (to_list will call it, which returns a function, then recursively call to_list on that)
    local func_returns_func = function()
        return function()
            return "nested"
        end
    end
    lu.assertEquals(feature.to_list(func_returns_func), { "nested" }, "Function returning function")

    -- Function with no explicit return (returns nil)
    local func_no_return = function()
        -- No return statement
    end
    lu.assertEquals(feature.to_list(func_no_return), {}, "Function with no return")

    -- Nested table
    lu.assertEquals(feature.to_list({ { "nested" } }), { { "nested" } }, "Nested table")

    -- Table with mixed types
    lu.assertEquals(feature.to_list({ 1, "a", true }), { 1, "a", true }, "Mixed type table")

    -- Table with nil values (Lua allows this)
    local table_with_nil = { 1, nil, 3 }
    lu.assertEquals(feature.to_list(table_with_nil), { 1, nil, 3 }, "Table with nil value")

    -- Function returning table with nil
    local func_returns_table_with_nil = function()
        return { 1, nil, 3 }
    end
    lu.assertEquals(feature.to_list(func_returns_table_with_nil), { 1, nil, 3 }, "Function returning table with nil")

    -- Table with metatable (should still work)
    local table_with_meta = setmetatable({ "a", "b" }, { __index = { c = "d" } })
    lu.assertEquals(feature.to_list(table_with_meta), { "a", "b" }, "Table with metatable")

    -- Function that returns multiple values (only first is used)
    local func_multi_return = function()
        return "first", "second"
    end
    lu.assertEquals(feature.to_list(func_multi_return), { "first" }, "Function with multiple returns")
end

function TestPollNumber()
    setup_mock_vim()

    -- Test State 1: Both enabled → number only
    _G.vim.o.number = true
    _G.vim.o.relativenumber = true
    feature.poll_number()
    lu.assertTrue(_G.vim.o.number, "State 1: number should be true")
    lu.assertFalse(_G.vim.o.relativenumber, "State 1: relativenumber should be false")

    -- Test State 2: number only → both disabled
    feature.poll_number()
    lu.assertFalse(_G.vim.o.number, "State 2: number should be false")
    lu.assertFalse(_G.vim.o.relativenumber, "State 2: relativenumber should be false")

    -- Test State 3: both disabled → both enabled
    feature.poll_number()
    lu.assertTrue(_G.vim.o.number, "State 3: number should be true")
    lu.assertTrue(_G.vim.o.relativenumber, "State 3: relativenumber should be true")

    -- Edge case: Start with only relativenumber=true, number=false
    _G.vim.o.number = false
    _G.vim.o.relativenumber = true
    feature.poll_number()
    lu.assertFalse(_G.vim.o.number, "Edge: number should be false")
    lu.assertFalse(_G.vim.o.relativenumber, "Edge: relativenumber should be false")
end

function TestXxdFunction()
    setup_mock_vim()

    -- Setup initial state tracking
    local cmd_calls = {}
    _G.vim.cmd = function(cmd)
        table.insert(cmd_calls, cmd)
    end
    _G.vim.b.is_xxd = nil
    _G.vim.o.mod = false
    _G.vim.o.binary = false

    -- Test 1: Initial toggle (normal → hex)
    _G.vim.b.is_xxd = nil
    _G.vim.o.mod = true -- Should preserve this
    cmd_calls = {}
    feature.xxd()

    lu.assertTrue(_G.vim.b.is_xxd, "After first toggle: is_xxd should be true")
    lu.assertTrue(_G.vim.o.binary, "After first toggle: binary should be true")
    lu.assertTrue(_G.vim.o.mod, "After first toggle: mod should be preserved as true")
    lu.assertEquals(#cmd_calls, 1, "Should execute %!xxd command")
    lu.assertEquals(cmd_calls[1], "silent %!xxd", "Should call xxd command")

    -- Test 2: Second toggle (hex → normal)
    _G.vim.o.mod = false -- Different state for second test
    cmd_calls = {}
    feature.xxd()

    lu.assertFalse(_G.vim.b.is_xxd, "After second toggle: is_xxd should be false")
    lu.assertFalse(_G.vim.o.binary, "After second toggle: binary should be false")
    lu.assertFalse(_G.vim.o.mod, "After second toggle: mod should be preserved as false")
    lu.assertEquals(#cmd_calls, 1, "Should execute %!xxd -r command")
    lu.assertEquals(cmd_calls[1], "silent %!xxd -r", "Should call xxd -r command")

    -- Test 3: Third toggle (normal → hex again)
    _G.vim.o.mod = true
    cmd_calls = {}
    feature.xxd()

    lu.assertTrue(_G.vim.b.is_xxd, "After third toggle: is_xxd should be true")
    lu.assertTrue(_G.vim.o.binary, "After third toggle: binary should be true")
    lu.assertTrue(_G.vim.o.mod, "After third toggle: mod should be preserved as true")

    -- Test 4: Verify vim.o.mod preservation for false state
    _G.vim.o.mod = false
    _G.vim.b.is_xxd = true
    feature.xxd()
    lu.assertFalse(_G.vim.o.mod, "Mod should be preserved as false")
end

function TestFormatFunction()
    setup_mock_vim()

    -- Track all vim operations
    local write_calls = {}
    local cmd_calls = {}
    local win_execute_calls = {}
    local redraw_count = 0

    _G.vim.cmd = function(cmd)
        table.insert(cmd_calls, cmd)
        if cmd == "redraw!" then
            redraw_count = redraw_count + 1
        end
    end

    _G.vim.fn.win_findbuf = function(bufnr)
        return { 1, 2 } -- Return two windows for testing
    end

    _G.vim.fn.win_execute = function(winnr, action)
        table.insert(win_execute_calls, { winnr = winnr, action = action })
    end

    -- Track shada calls
    local shada_calls = 0
    local orig_cmd = _G.vim.cmd
    _G.vim.cmd = function(cmd)
        table.insert(cmd_calls, cmd)
        if cmd == "wshada" or cmd == "rshada" then
            shada_calls = shada_calls + 1
        end
        if cmd == "redraw!" then
            redraw_count = redraw_count + 1
        end
    end

    _G.vim.api.nvim_get_current_buf = function()
        return 42
    end

    -- Mock modified state - should trigger save
    _G.vim.o.mod = true
    _G.vim.api.nvim_buf_get_name = function()
        return "test.txt"
    end

    -- Test 1: Format with modified buffer (should save before/after)
    local formatter_called = false
    local test_formatter = function()
        formatter_called = true
    end

    feature.format(test_formatter)

    lu.assertTrue(formatter_called, "Formatter should be called")
    lu.assertFalse(_G.vim.o.lazyredraw, "lazyredraw should be disabled after format completes")

    -- Check that write was called for modified buffer
    local has_noautocmd_write = false
    for _, cmd in ipairs(cmd_calls) do
        if cmd:match("noautocmd silent write") then
            has_noautocmd_write = true
            break
        end
    end
    lu.assertTrue(has_noautocmd_write, "Should write modified buffer")

    -- Check win_execute was called for view saving/restoring
    lu.assertEquals(#win_execute_calls, 4, "Should call win_execute twice per window (save + restore)") -- 2 windows x 2 (save+restore)
    -- First two should be saveview, last two should be winrestview
    lu.assertTrue(win_execute_calls[1].action:find("winsaveview") ~= nil, "First calls should save view")

    -- Check shada was saved/restored
    lu.assertTrue(shada_calls >= 2, "Shada should be saved and restored")

    -- Check redraw
    lu.assertTrue(redraw_count >= 1, "Should have called redraw")

    -- Check lazyredraw is disabled at end
    lu.assertFalse(_G.vim.o.lazyredraw, "lazyredraw should be disabled after format")

    -- Test 2: Format with unmodified buffer (should not save)
    write_calls = {}
    cmd_calls = {}
    _G.vim.o.mod = false
    formatter_called = false
    feature.format(test_formatter)

    lu.assertTrue(formatter_called, "Formatter should be called")
    -- Check no write was called for unmodified buffer
    local has_write = false
    for _, cmd in ipairs(cmd_calls) do
        if cmd:match("write") and not cmd:match("shada") then
            has_write = true
            break
        end
    end
    lu.assertFalse(has_write, "Should not write unmodified buffer")
end

function TestHigherOrderFunctions()
    setup_mock_vim()

    -- Test that feature returns expected structure
    lu.assertEquals(type(feature.poll_number), "function")
    lu.assertEquals(type(feature.xxd), "function")
    lu.assertEquals(type(feature.format), "function")
    lu.assertEquals(type(feature.get_relative_path), "function")
    lu.assertEquals(type(feature.parse_args), "function")
    lu.assertEquals(type(feature.to_list), "function")
end

os.exit(lu.LuaUnit.run())
