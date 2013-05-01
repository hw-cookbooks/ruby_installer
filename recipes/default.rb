
# Used by other recipes
ohai "ruby" do
  action :nothing
end

node[:ruby_installer][:package_removals].each do |r_pkg|
  package r_pkg do
    action :remove
  end
end

case node[:ruby_installer][:method]
when 'package'
  include_recipe 'ruby_installer::package'
when 'ree'
  include_recipe 'ruby_installer::ree'
when 'source'
  include_recipe 'ruby_installer::source'
else
  Chef::Log.error "[ruby_installer]: Unknown installation method requested (#{node[:ruby_installer][:method]})"
  raise "Unknown ruby installation method requested"
end

