package("qlibc")
    set_homepage("http://wolkykim.github.io/qlibc")
    set_description("qLibc is a simple and yet powerful C library providing generic data structures and algorithms")

    add_urls("https://github.com/wolkykim/qlibc/archive/refs/tags/$(version).tar.gz",
             "https://github.com/wolkykim/qlibc.git")
    add_versions("v2.4.8", "e4cb1d40190e5fdd517d9e7ecdffb5ca728d80ff3d5e8308f4d1ba3b0162d433")

    on_install(function (package)
        local configs = { "--without-openssl", "--without-mysql" }
        import("package.tools.autoconf").install(package, configs)
    end)

    on_test(function (package)
        assert(package:has_cfuncs("qvector", {includes = "qlibc/qlibc.h"}))
    end)
