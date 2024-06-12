package('libsock', function()
  set_homepage('https://github.com/RunThem/libsock')
  set_description('Wrapper library for the BSD sockets API with a nicer C99 interface')
  set_license('MIT')

  add_urls('https://github.com/RunThem/libsock.git')

  on_install(function(package)
    import('package.tools.xmake').install(package, {})
  end)

  on_test(function(package)
    assert(package:has_cfuncs('sock_open', { includes = 'libsock.h' }))
  end)
end)
