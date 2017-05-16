name             'ruby_installer'
maintainer       'Chris Roberts'
maintainer_email 'chrisroberts.code@gmail.com'
license          'Apache 2.0'
description      'Installs ruby'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'
issues_url       'https://github.com/hw-cookbooks/ruby_installer/issues' if respond_to?(:issues_url)
source_url       'https://github.com/hw-cookbooks/ruby_installer' if respond_to?(:source_url)
chef_version     '>= 12.5.0'
supports         'linux'
depends 'apt'
depends 'ark', '~> 3.1.0'
depends 'build-essential', '~> 8.0'
