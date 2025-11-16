lu = require("luaunit")

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

os.exit(lu.LuaUnit.run())
