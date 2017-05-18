#
# Cookbook Name:: ruby_installer
# Recipe:: default
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
