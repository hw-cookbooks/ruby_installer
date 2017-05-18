#
# Cookbook Name:: ruby_installer
# Recipe:: ree
#
# Copyright 2012-2014, Chris Roberts <chrisroberts.code@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
