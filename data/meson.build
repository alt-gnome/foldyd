service = 'foldyd.service'

generated_service = configure_file(
  output: service,
  input: service + '.in',
  configuration: conf,
)

install_data(
  generated_service,
  install_dir: join_paths(get_option('prefix'), 'lib/systemd/user')
)
