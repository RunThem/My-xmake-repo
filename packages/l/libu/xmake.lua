package('libu', function()
  set_homepage('https://github.com/RunThem/libu')
  set_description('A small C library')
  set_license('MIT')

  add_urls('https://github.com/RunThem/libu.git')

  add_deps('mimalloc', 'tgc')

  on_install(function(package)
    import('package.tools.xmake').install(package, {})
  end)

  on_test(function(package)
    assert(package:has_ctypes('any_t', { configs = { languages = 'c23' }, includes = { 'u/u.h' } }))
  end)
end)
