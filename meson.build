project(
  'foldyd',
  ['c', 'vala'],
  version: '0.1.0',
  meson_version: '>= 1.0.0',
  license: 'GPL-3.0-or-later',
)

glib_min_version = '2.72'

gio_dep = dependency('gio-unix-2.0', version: '>= ' + glib_min_version)
gee_dep = dependency('gee-0.8')
libfoldy_dep = dependency('libfoldy-1', fallback : ['libfoldy', 'lib_dep'])

dependencies = [
  gio_dep,
  gee_dep,
  libfoldy_dep,
]

gnome = import('gnome')

conf = configuration_data()
conf.set('bindir', get_option('prefix') / get_option('bindir'))
conf.set('datadir', get_option('prefix') / get_option('datadir'))

add_project_arguments(
  '--target-glib', glib_min_version,
  '--vapidir', meson.current_source_dir(),
  language: ['vala'],
)

subdir('data')
subdir('src')

gnome.post_install(
  glib_compile_schemas: true,
)
