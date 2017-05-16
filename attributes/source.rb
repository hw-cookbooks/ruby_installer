# Source attributes

default['ruby_installer']['source_version'] = '1.9.3-p551'
default['ruby_installer']['source_install_dir'] = '/usr/local'
default['ruby_installer']['source_rubygems_version'] = '1.8.24'
default['ruby_installer']['source_rubygems_force'] = false
default['ruby_installer']['source_optimize'] = false
default['ruby_installer']['source_optimization_level'] = 1
default['ruby_installer']['source_falcon_patch'] = false
default['ruby_installer']['source_package_dependencies'] = value_for_platform_family(
  %w(rhel fedora) => %w(readline readline-devel zlib zlib-devel libyaml-devel libffi-devel openssl-devel bzip2 autoconf libtool bison),
  'debian' => %w(openssl libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison)
)
