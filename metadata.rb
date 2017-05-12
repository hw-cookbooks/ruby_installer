name             'ruby_installer'
maintainer       'Chris Roberts'
maintainer_email 'chrisroberts.code@gmail.com'
license          'Apache 2.0'
description      'Installs ruby'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'
issues_url 'https://github.com/chef-cookbooks/something/issues' if respond_to?(:issues_url)
source_url 'https://github.com/chef-cookbooks/something' if respond_to?(:source_url)

%w(oracle centos redhat scientific enterpriseenterprise fedora amazon ubuntu debian mint).each do |os|
  supports os
end

depends 'build-essential'
