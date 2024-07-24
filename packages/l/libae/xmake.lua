package('libae', function()
  set_homepage('https://github.com/aisk/libae')
  set_description("redis's async event loop library")
  set_license('BSD-3-Clause')

  add_urls('https://github.com/aisk/libae.git')

  on_install(function(package)
    local configs = {}
    io.writefile(
      'xmake.lua',
      [[
add_rules("mode.debug", "mode.release")
target("ae", function()
  set_kind("static")
  add_files("src/ae.c", "src/anet.c")
  add_headerfiles("src/ae.h", "src/anet.h", { prefixdir = 'libae' })
end)
]]
    )

    import('package.tools.xmake').install(package, configs)
  end)

  on_test(function(package)
    assert(package:has_cfuncs('aeMain', { includes = 'libae/ae.h' }))
  end)
end)
