package("parson")
    set_homepage("https://github.com/kgabis/parson")
    set_description("Lightweight JSON library written in C.")
    set_license("MIT")

    add_urls("https://github.com/kgabis/parson.git")
    add_versions("2023.02.15", "3c4ee26dbb3df177a2d7b9d80e154ec435ca8c01")

    on_install(function (package)
        io.writefile("xmake.lua", [[
        add_rules("mode.debug", "mode.release")
        target("parson")
            set_kind("static")
            add_files("parson.c")
            add_headerfiles("parson.h")
        ]])
        import("package.tools.xmake").install(package)
    end)

    on_test(function (package)
        assert(package:has_cfuncs("json_parse_file", {includes = "parson.h"}))
    end)
