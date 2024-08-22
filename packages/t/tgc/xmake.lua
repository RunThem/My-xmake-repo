package('tgc', function()
  set_homepage('https://github.com/orangeduck/tgc')
  set_description('A Tiny Garbage Collector for C')

  add_urls('https://github.com/orangeduck/tgc.git')
  add_versions('2023.06.26', '81ce102bfd52ee7dba53ec69b4d6a81b0e58c8d4')

  on_install(function(package)
    io.writefile(
      'xmake.lua',
      [[
add_rules("mode.release", "mode.debug")

target("%s", function()
  set_kind("static")
  add_files("*.c")
  add_headerfiles("*.h")
end)
]]
    )

    import('package.tools.xmake').install(package, {})
  end)

  on_test(function(package)
    assert(package:has_cfuncs('tgc_start', { includes = 'tgc.h' }))
  end)
end)
