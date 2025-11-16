lu = require("luaunit")

local feature = require("feature")

function TestParseArgs()
    lu.assertEquals(feature.parse_args({}), {})
    lu.assertEquals(feature.parse_args(""), {})
    lu.assertEquals(feature.parse_args("foobar"), { "foobar" })
    lu.assertEquals(feature.parse_args(" foobar "), { "foobar" })
    lu.assertEquals(feature.parse_args("-a -b foobar"), { "-a", "-b", "foobar" })
    lu.assertEquals(feature.parse_args(" -a -b foobar "), { "-a", "-b", "foobar" })
    lu.assertEquals(feature.parse_args(" -a   -b foobar "), { "-a", "-b", "foobar" })
    lu.assertEquals(feature.parse_args(" -a '-b foobar '"), { "-a", "-b foobar " })
    lu.assertEquals(feature.parse_args(" -a    '-b foobar '"), { "-a", "-b foobar " })
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
