package_name = node['ruby_installer']['package_name']
dev_name = node['ruby_installer']['rubydev_package']
gem_name = node['ruby_installer']['rubygem_package']

[package_name, dev_name, gem_name].each do |pkg|
  package pkg do
    action :upgrade
    notifies :reload, 'ohai[ruby]', :immediately
  end
end
