#
# Cookbook Name:: ruby_installer
# Recipe:: source
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

include_recipe 'build-essential'
ruby_ver = node['ruby_installer']['source_version']

node['ruby_installer']['source_package_dependencies'].each do |pkg|
  package pkg
end

remote_file "/usr/src/ruby-#{ruby_ver}.tar.gz" do
  source "http://ftp.ruby-lang.org/pub/ruby/#{ruby_ver[0..2]}/ruby-#{ruby_ver}.tar.gz"
  action :create_if_missing
  not_if { Mixlib::ShellOut.new('ruby --version').run_command.stdout.include?(ruby_ver) }
end

execute 'Extract Ruby' do
  cwd '/usr/src'
  command "tar xvzf ruby-#{ruby_ver}.tar.gz"
  creates "/usr/src/ruby-#{ruby_ver}"
end

include_recipe 'ruby_installer::_source_patch'

bash 'install_ruby' do
  cwd "/usr/src/ruby-#{ruby_ver}"
  code <<-EOH
    autoconf
    ./configure --prefix=#{node['ruby_installer']['source_install_dir']} --disable-install-doc --enable-shared
    make -j#{node['cpu']['total'] + 1}
    make install
  EOH
  action :nothing
  subscribes :run, 'execute[Extract Ruby]'
  not_if { Mixlib::ShellOut.new('ruby --version').run_command.stdout.include?(ruby_ver) }
  notifies :reload, 'ohai[ruby]', :immediately
  if node['ruby_installer']['source_optimize']
    environment cflags: "-march=native -pipe -fomit-frame-pointer -O#{node['ruby_installer']['source_optimization_level']}"
  end
end

rin_ver = Gem::Version.new(ruby_ver.match(/(\d+\.?){2,3}/).to_s)

if rin_ver < Gem::Version.new('1.9.0') || node['ruby_installer']['source_rubygems_force']
  include_recipe 'ruby_installer::source_rubygems'
end

include_recipe 'ruby_installer::_ruby_path'
