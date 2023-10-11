package("libsock")
    set_homepage("https://github.com/RunThem/libsock")
    set_description("Wrapper library for the BSD sockets API with a nicer C99 interface")
    set_license("MIT")

    add_urls("https://github.com/RunThem/libsock.git")
    add_versions("2023.10.12", "5e70c16c28b74f20cce53ae60a0830f04eda38c7")

    on_install(function (package)
        import("package.tools.xmake").install(package, {})
    end)

    on_test(function (package)
        assert(package:has_cfuncs("sock_open", {includes = "libsock.h"}))
    end)
