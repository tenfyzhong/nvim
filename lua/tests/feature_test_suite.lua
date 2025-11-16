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

os.exit(lu.LuaUnit.run())
