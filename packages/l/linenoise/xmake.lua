package('linenoise', function()
  set_homepage('https://github.com/antirez/linenoise')
  set_description('A small self-contained alternative to readline and libedit')
  set_license('BSD-2-Clause')

  add_urls('https://github.com/antirez/linenoise.git')

  on_install(function(package)
    local configs = {}
    io.writefile(
      'xmake.lua',
      [[
add_rules("mode.release", "mode.debug")

target("linenoise", function()
  set_kind("static")
  add_files("linenoise.c")
  add_headerfiles("linenoise.h")
end)
]]
    )

    if package:config('shared') then
      configs.kind = 'shared'
    end

    import('package.tools.xmake').install(package, configs)
  end)

  on_test(function(package)
    assert(package:has_cfuncs('linenoise', { includes = { 'stddef.h', 'linenoise.h' } }))
  end)
end)
