package('dbg-macro', function()
  set_homepage('https://github.com/eerimoq/dbg-macro')
  set_description('A set of dbg(…) macros for C')
  set_license('MIT')

  add_urls('https://github.com/eerimoq/dbg-macro.git')
  add_versions('2020.04.14', 'b949858d9dff4886e68f1049270aad1b3fa7ab81')

  on_install(function(package)
    local configs = {}

    io.writefile(
      'xmake.lua',
      [[
add_rules("mode.release", "mode.debug")

target("cc", function()
  set_kind("$(kind)")
  add_headerfiles("include/dbg.h")
end)
]]
    )

    import('package.tools.xmake').install(package, configs)
  end)

  on_test(function(package)
    assert(package:check_csnippets({
      test = [[
#include <dbg.h>

void test(int argc, char** argv) {
    char message[] = "hello";
    dbg(message);  // main.c:15: message = "hello"
    dbgh(message, sizeof(message));
}
]],
    }, { configs = { languages = 'c11' }, includes = 'dbg.h' }))
  end)
end)
