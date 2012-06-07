
package node[:ruby_installer][:package_name] do
  action :upgrade
  notifies :reload, resources(:ohai => 'ruby'), :immediately
end

if(node[:ruby_installer][:rubygem_package])
  package node[:ruby_installer][:rubygem_package].is_a?(String) ? node[:ruby_installer][:rubygem_package] : 'rubygems' do
    action :upgrade
    notifies :reload, resources(:ohai => 'ruby'), :immediately
  end
end

if node[:ruby_installer][:rubydev_package]
  package node[:ruby_installer][:rubydev_package].is_a?(String) ? node[:ruby_installer][:rubydev_package] : 'ruby-dev' do
    action :upgrade
    notifies :reload, resources(:ohai => 'ruby'), :immediately
  end
end
