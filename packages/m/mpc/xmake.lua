package('mpc', function()
  set_homepage('https://github.com/orangeduck/mpc')
  set_description('A Parser Combinator library for C')
  set_license('BSD')

  add_urls(
    'https://github.com/orangeduck/mpc/archive/refs/tags/$(version).tar.gz',
    'https://github.com/orangeduck/mpc.git'
  )
  add_versions('0.9.0', 'da6e798accec57d7b0512ecc38adc151961adefde09811c1c25ee993a653e47c')

  on_install(function(package)
    local configs = {}
    io.writefile(
      'xmake.lua',
      [[
add_rules("mode.debug", "mode.release")

target("mpc", function()
  set_kind("static")
  add_files("mpc.c")
  add_headerfiles("mpc.h")
end)
]]
    )

    import('package.tools.xmake').install(package, configs)
  end)

  on_test(function(package)
    assert(package:has_cfuncs('mpc_new', { includes = 'mpc.h' }))
  end)
end)
