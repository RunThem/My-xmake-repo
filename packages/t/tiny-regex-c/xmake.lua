package('tiny-regex-c', function()
  set_homepage('https://github.com/kokke/tiny-regex-c')
  set_description('Small portable regex in C')
  set_license('Unlicense')

  add_urls('https://github.com/kokke/tiny-regex-c.git')

  on_install(function(package)
    local configs = {}
    io.writefile(
      'xmake.lua',
      [[
add_rules("mode.release", "mode.debug")

target("tiny-regex-c", function()
  set_kind("$(kind)")
  add_files("re.c")
  add_headerfiles("re.h")
end)
]]
    )

    import('package.tools.xmake').install(package, configs)
  end)

  on_test(function(package)
    assert(package:has_cfuncs('re_match', { includes = 're.h' }))
  end)
end)
