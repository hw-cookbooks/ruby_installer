#
# Cookbook Name:: ruby_installer
# Recipe:: _ruby_path
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

file '/etc/profile.d/ruby_path.sh' do
  content "export PATH=#{node['ruby_installer']['source_install_dir']}/bin:$PATH"
  mode '0644'
  only_if { node['ruby_installer']['set_path?'] }
end
