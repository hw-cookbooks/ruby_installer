# Package attributes

default['ruby_installer']['package_name'] = value_for_platform_family(
  'debian' => 'ruby-full',
  'default' => 'ruby'
)
default['ruby_installer']['rubydev_package'] = value_for_platform_family(
  'debian' => 'ruby-dev',
  'default' => 'ruby-devel'
)
default['ruby_installer']['rubygem_package'] = value_for_platform_family(
  'debian' => 'rubygems-integration',
  'default' => 'rubygems'
)
