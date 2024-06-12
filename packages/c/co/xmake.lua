package('co', function()
  set_homepage('https://github.com/RunThem/co')
  set_description("A simple 'setjmp()' based coroutine library.")
  set_license('MIT')

  add_urls('https://github.com/RunThem/co.git')

  add_deps('libsock')

  on_install(function(package)
    local configs = {}
    import('package.tools.xmake').install(package, configs)
  end)

  on_test(function(package)
    assert(package:has_cfuncs('co_init', { includes = 'co.h' }))
  end)
end)
