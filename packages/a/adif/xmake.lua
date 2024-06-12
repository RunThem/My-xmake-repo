package('adif', function()
  set_homepage('https://github.com/kehengzhong/adif')
  set_description(
    '用标准c语言开发的常用数据结构和算法基础库，作为应用程序开发接口基础库，为编写高性能程序提供便利，可极大地缩短软件项目的开发周期，提升工程开发效率，并确保软件系统运行的可靠性、稳定性。'
  )
  set_license('MIT')

  add_urls(
    'https://github.com/kehengzhong/adif/archive/refs/tags/$(version).tar.gz',
    'https://github.com/kehengzhong/adif.git'
  )
  add_versions('v2.6.30', '2fd776f9c41f5d8d886a9bbed34a7023a502a28cb2068ef0c80601679e8a996f')

  on_install(function(package)
    local configs = {}

    io.writefile(
      'xmake.lua',
      [[
add_rules("mode.release", "mode.debug")
target("adif", function()
  set_kind("$(kind)")
  add_files("src/*.c")
  add_includedirs('include')
  add_headerfiles("include/*.h")

  add_defines('UNIX', '_LINUX_')
  add_cflags('-m64')
end)
]]
    )

    import('package.tools.xmake').install(package, configs)
  end)

  on_test(function(package)
    assert(package:has_cfuncs('lt_new', { includes = { 'adif/dynarr.h', 'adif/dlist.h' } }))
  end)
end)
