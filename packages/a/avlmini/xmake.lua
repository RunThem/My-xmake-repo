package('avlmini', function()
  set_homepage('https://github.com/skywind3000/avlmini')
  set_description("AVL implementation which is as fast/compact as linux's rbtree")
  set_license('MIT')

  add_urls('https://github.com/skywind3000/avlmini.git')

  on_install(function(package)
    local configs = {}
    io.writefile(
      'xmake.lua',
      [[
add_rules("mode.debug", "mode.release")
target("avlmini", function()
  set_kind("static")
  add_files("avlmini.c", "avlhash.c")
  add_headerfiles("avlmini.h", "avlhash.h")
end)
]]
    )

    import('package.tools.xmake').install(package, configs)
  end)

  on_test(function(package)
    assert(package:has_cfuncs('avl_node_first', { includes = 'avlmini.h' }))
  end)
end)
