name             'ruby_installer'
maintainer       'Chris Roberts'
maintainer_email 'chrisroberts.code@gmail.com'
license          'Apache-2.0'
description      'Installs ruby'
version          '0.1.3'

%w(oracle centos redhat scientific enterpriseenterprise fedora amazon ubuntu debian linuxmint).each do |os|
  supports os
end
