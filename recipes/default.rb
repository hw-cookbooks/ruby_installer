
include_recipe 'apt' if node['platform_family'] == 'debian'
# Used by other recipes
ohai 'ruby' do
  action :nothing
end

node['ruby_installer']['package_removals'].each do |r_pkg|
  package r_pkg do
    action :remove
  end
end

include_recipe "ruby_installer::#{node['ruby_installer']['method']}"
