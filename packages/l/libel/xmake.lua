package('libel', function()
  set_homepage('https://github.com/luohaha/libel')
  set_description('An event-driven library.')

  add_urls('https://github.com/luohaha/libel.git')

  on_install('linux', function(package)
    local configs = {}

    io.writefile(
      'core/config.h',
      [[
#define HAVE_EPOLL_H 1

#ifdef HAVE_KQUEUE_H
# undef HAVE_KQUEUE_H
#endif
]]
    )

    io.writefile(
      'xmake.lua',
      [[
add_rules("mode.debug", "mode.release")
target("el", function()
  set_kind("static")
  add_files("core/*.c")
  add_headerfiles("core/*.h", { prefixdir = 'libel' })
end)
]]
    )

    import('package.tools.xmake').install(package, configs)
  end)

  on_install('macosx', 'bsd', function(package)
    local configs = {}

    io.writefile(
      'core/config.h',
      [[
#define HAVE_EPOLL_H 1
#define HAVE_KQUEUE_H 1

#ifdef HAVE_EPOLL_H
# undef HAVE_EPOLL_H
#endif
]]
    )

    io.writefile(
      'xmake.lua',
      [[
add_rules("mode.debug", "mode.release")
target("el", function()
  set_kind("static")
  add_files("core/*.c")
  add_headerfiles("core/*.h", { prefixdir = 'libel' })
end)
]]
    )

    import('package.tools.xmake').install(package, configs)
  end)

  on_test(function(package)
    assert(package:has_cfuncs('el_loop_new', { includes = 'libel/el.h' }))
  end)
end)
