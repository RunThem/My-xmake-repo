package('parson', function()
  set_homepage('https://github.com/kgabis/parson')
  set_description('Lightweight JSON library written in C.')
  set_license('MIT')

  add_urls('https://github.com/kgabis/parson.git')

  on_install(function(package)
    local configs = {}
    io.writefile(
      'xmake.lua',
      [[
add_rules("mode.debug", "mode.release")
target("parson", function()
  set_kind("static")
  add_files("parson.c")
  add_headerfiles("parson.h")
end)
]]
    )

    import('package.tools.xmake').install(package, configs)
  end)

  on_test(function(package)
    assert(package:has_cfuncs('json_parse_file', { includes = 'parson.h' }))
  end)
end)
