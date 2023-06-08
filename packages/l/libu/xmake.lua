package("libu")

    set_homepage("https://github.com/RunThem/libu")
    set_description("A small C library")

    add_urls("https://github.com/RunThem/libu.git")

    on_install(function (package)
        import("package.tools.xmake").install(package, {})
    end)

    -- on_test(function (package)
    --     assert(package:has_cfuncs("inf", {includes = {"u/u.h"}}))
    -- end)
