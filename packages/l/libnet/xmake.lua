package("libnet")
    set_homepage("https://codedocs.xyz/libnet/libnet/")
    set_description("A portable framework for low-level network packet construction")

    add_urls("https://github.com/libnet/libnet/archive/refs/tags/$(version).tar.gz",
             "https://github.com/libnet/libnet.git")
    add_versions("v1.2", "b7a371a337d242c017f3471d70bea2963596bec5bd3bd0e33e8517550e2311ef")

    add_deps("autoconf", "automake", "libtool")

    on_install(function (package)
        local configs = {}
        table.insert(configs, "--enable-shared=no")
        import("package.tools.autoconf").install(package, configs)
    end)

    on_test(function (package)
        assert(package:has_cfuncs("libnet_init", {includes = "libnet.h"}))
    end)
