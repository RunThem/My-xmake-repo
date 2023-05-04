package("tiny-regex-c")
    set_homepage("https://github.com/kokke/tiny-regex-c")
    set_description("Small portable regex in C")

    add_urls("https://github.com/kokke/tiny-regex-c.git")
    add_versions("2021.06.11", "2d306a5a71128853d18292e8bb85c8e745fbc9d0")

    on_install(function (package)
        local configs = {}
        io.writefile("xmake.lua", [[
            add_rules("mode.release", "mode.debug")
            target("tiny-regex-c")
                set_kind("$(kind)")
                add_files("re.c")
                add_headerfiles("re.h")
        ]])
        import("package.tools.xmake").install(package, configs)
    end)

    on_test(function (package)
        assert(package:has_cfuncs("re_match", {includes = "re.h"}))
    end)
