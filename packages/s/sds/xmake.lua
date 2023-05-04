package("sds")
    set_homepage("https://github.com/antirez/sds")
    set_description("Simple Dynamic Strings library for C")

    add_urls("https://github.com/antirez/sds.git")
    add_versions("2022.12.11", "a9a03bb3304030bb8a93823a9aeb03c157831ba9")

    on_install(function (package)
        local configs = {}
        io.writefile("xmake.lua", [[
            add_rules("mode.release", "mode.debug")
            target("sds")
                set_kind("$(kind)")
                add_files("*.c")
                add_headerfiles("*.h")
        ]])
        import("package.tools.xmake").install(package, configs)
    end)

    on_test(function (package)
        assert(package:has_cfuncs("sdsnew", {includes = "sds.h"}))
    end)
