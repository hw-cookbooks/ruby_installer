#
# Cookbook Name:: ruby_installer
# Recipe:: source_rubygems
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

rubygem_ver = node['ruby_installer']['source_rubygems_version']
bin_dir = "#{node['ruby_installer']['source_install_dir']}/bin"

remote_file "/usr/src/rubygems-#{rubygem_ver}.tgz" do
  source "http://production.cf.rubygems.org/rubygems/rubygems-#{rubygem_ver}.tgz"
  action :create_if_missing
  not_if { Mixlib::ShellOut.new("#{bin_dir}/gem --version").run_command.stdout.include?(rubygem_ver) }
end

bash 'install_rubygems' do
  cwd '/usr/src'
  code <<-EOH
    tar -zxf rubygems-#{rubygem_ver}.tgz
    cd rubygems-#{rubygem_ver}
    #{bin_dir}/ruby setup.rb
  EOH
  not_if { Mixlib::ShellOut.new("#{bin_dir}/gem --version").run_command.stdout.include?(rubygem_ver) }
end
