package('qlibc', function()
  set_homepage('http://wolkykim.github.io/qlibc')
  set_description('qLibc is a simple and yet powerful C library providing generic data structures and algorithms')

  add_urls(
    'https://github.com/wolkykim/qlibc/archive/refs/tags/$(version).tar.gz',
    'https://github.com/wolkykim/qlibc.git'
  )

  add_versions('v2.4.8', 'e4cb1d40190e5fdd517d9e7ecdffb5ca728d80ff3d5e8308f4d1ba3b0162d433')
  add_versions('v2.5.0', '68d94419c0d48c881d97ac76971f703668a812a37e95261cd540748d5f9ca790')

  add_patches('v2.4.8', path.join(os.scriptdir(), 'patches', 'ssize_t.patch'))
  add_patches('v2.5.0', path.join(os.scriptdir(), 'patches', 'ssize_t.patch'))

  on_install(function(package)
    local configs = { '--without-openssl', '--without-mysql' }
    import('package.tools.autoconf').install(package, configs)
  end)

  on_test(function(package)
    assert(package:has_cfuncs('qvector', { includes = 'qlibc/qlibc.h' }))
  end)
end)
