package("mini-unit-test")
    set_homepage("https://github.com/RunThem/Mini-Unit-Test")
    set_description("tiny unit testing framework for ANSI C")
    set_license("MIT")

    add_urls("https://github.com/RunThem/Mini-Unit-Test.git")

    on_install(function (package)
        io.writefile("xmake.lua", [[
            add_rules("mode.release", "mode.debug")
            target("mini-unit-test")
                set_kind("$(kind)")
                add_headerfiles("mut.h")
        ]])
        import("package.tools.xmake").install(package)
    end)

    on_test(function (package)
        assert(package:check_csnippets({
          test = [[
#include <mut.h>
void test(int argc, char** argv) {
    mut_init("hello xmake");

    mut_results();
}
          ]]
        }, {configs = {languages = "c11"}, includes = "mut.h"}))
    end)
