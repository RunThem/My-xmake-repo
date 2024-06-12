package('coroutine', function()
  set_homepage('https://github.com/cloudwu/coroutine')
  set_description('A asymmetric coroutine library for C.')
  set_license('MIT')

  add_urls('https://github.com/cloudwu/coroutine.git')

  on_install(function(package)
    io.writefile(
      'xmake.lua',
      [[
add_rules("mode.release", "mode.debug")

target("coroutine", function()
  set_kind("$(kind)")
  add_files("coroutine.c")
  add_headerfiles("coroutine.h")
end)
]]
    )

    import('package.tools.xmake').install(package)
  end)

  on_test(function(package)
    assert(package:has_cfuncs('coroutine_open', { includes = 'coroutine.h' }))
  end)
end)
