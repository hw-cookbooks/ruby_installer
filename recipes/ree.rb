
ruby_ver = File.basename(node['ruby_installer']['ree_source_url']).sub('.tar.gz', '')

include_recipe 'build-essential'
node['ruby_installer']['ree_package_dependencies'].each do |pkg|
  package pkg
end

remote_file "/usr/src/#{File.basename(node['ruby_installer']['ree_source_url'])}" do
  source node['ruby_installer']['ree_source_url']
  not_if do
    File.exist?("/usr/src/#{File.basename(node['ruby_installer']['ree_source_url'])}")
  end
end

execute 'Extract REE' do
  cwd '/usr/src'
  command "tar xvzf #{File.basename(node['ruby_installer']['ree_source_url'])}"
  creates "/usr/src/#{ruby_ver}"
end

include_recipe 'ruby_installer::_ree_patch'

execute 'Install REE' do
  cwd "/usr/src/#{File.basename(node['ruby_installer']['ree_source_url']).sub('.tar.gz', '')}"
  command "./installer --auto=#{node['ruby_installer']['source_install_dir']}"
  action :nothing
  subscribes :run, 'execute[Extract REE]'
  notifies :reload, 'ohai[ruby]', :immediately
end

include_recipe 'ruby_installer::_ruby_path'
