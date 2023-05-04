package("cc")
    set_homepage("https://github.com/JacksonAllan/CC")
    set_description("A small, usability-oriented generic container library.")

    add_urls("https://github.com/JacksonAllan/CC/archive/refs/tags/$(version).tar.gz",
             "https://github.com/JacksonAllan/CC.git")
    add_versions("v1.0.3", "5192aae6df0c40f4990b6721ad82e8049f560c6189adb59651c2fb366796a4dc")

    on_install(function (package)
        local configs = {}
        io.writefile("xmake.lua", [[
            add_rules("mode.release", "mode.debug")
            target("cc")
                set_kind("$(kind)")
                add_headerfiles("cc.h")
        ]])
        import("package.tools.xmake").install(package, configs)
    end)

    -- on_test(function (package)
    --     assert(package:has_cfuncs("foo", {includes = "foo.h"}))
    -- end)
