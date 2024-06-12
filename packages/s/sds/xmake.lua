package('sds', function()
  set_homepage('https://github.com/antirez/sds')
  set_description('Simple Dynamic Strings library for C')
  set_license('BSD-2-Clause')

  add_urls('https://github.com/antirez/sds.git')

  on_install(function(package)
    local configs = {}
    io.writefile(
      'xmake.lua',
      [[
add_rules("mode.release", "mode.debug")

target("sds", function()
  set_kind("$(kind)")
  add_files("*.c")
  add_headerfiles("*.h")
end)
]]
    )

    import('package.tools.xmake').install(package, configs)
  end)

  on_test(function(package)
    assert(package:has_cfuncs('sdsnew', { includes = 'sds.h' }))
  end)
end)
