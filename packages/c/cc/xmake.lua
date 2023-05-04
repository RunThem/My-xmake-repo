package("cc")
    set_homepage("https://github.com/JacksonAllan/CC")
    set_description("A small, usability-oriented generic container library.")

    add_urls("https://github.com/JacksonAllan/CC.git")

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
    --     assert(package:has_cfuncs("init", {includes = "cc.h"}))
    -- end)
