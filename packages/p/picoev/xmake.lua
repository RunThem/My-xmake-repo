package('picoev', function()
  set_homepage('https://github.com/kazuho/picoev')
  set_description('a tiny, lightning fast event loop for network applications')

  add_urls('https://github.com/kazuho/picoev.git')

  on_install('linux', function(package)
    local configs = {}
    io.writefile(
      'xmake.lua',
      [[
add_rules("mode.debug", "mode.release")
target("picoev", function()
  set_kind("static")
  add_files("picoev_epoll.c")
  add_headerfiles("picoev.h")
end)
]]
    )

    import('package.tools.xmake').install(package, configs)
  end)

  on_install('macosx', 'bsd', function(package)
    local configs = {}
    io.writefile(
      'xmake.lua',
      [[
add_rules("mode.debug", "mode.release")
target("picoev", function()
  set_kind("static")
  add_files("picoev_kqueue.c")
  add_headerfiles("picoev.h")
end)
]]
    )

    import('package.tools.xmake').install(package, configs)
  end)

  on_test(function(package)
    assert(package:has_cfuncs('picoev_init', { includes = 'picoev.h' }))
  end)
end)
