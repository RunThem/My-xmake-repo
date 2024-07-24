package('libyuarel', function()
  set_homepage('https://github.com/jacketizer/libyuarel')
  set_description('Simple C library for parsing URLs with zero-copy and no mallocs.')

  add_urls('https://github.com/jacketizer/libyuarel.git')

  on_install(function(package)
    local configs = {}
    io.writefile(
      'xmake.lua',
      [[
add_rules("mode.debug", "mode.release")
target("yuarel", function()
  set_kind("static")
  add_files("yuarel.c")
  add_headerfiles("yuarel.h", { prefixdir = 'libyuarel' })
end)
]]
    )

    import('package.tools.xmake').install(package, configs)
  end)

  on_test(function(package)
    assert(package:has_cfuncs('yuarel_parse', { includes = 'libyuarel/yuarel.h' }))
  end)
end)
