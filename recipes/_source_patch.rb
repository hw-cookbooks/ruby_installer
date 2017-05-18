#
# Cookbook Name:: ruby_installer
# Recipe:: _source_patch
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

cache = Chef::Config['file_cache_path']
ruby_ver = node['ruby_installer']['source_version']

if node['ruby_installer']['source_falcon_patch']
  cookbook_file "#{cache}/falcon-gc.diff"

  execute 'install falcon patch' do
    command "patch -Np1 /usr/src/ruby-#{ruby_ver} < #{cache}/falcon-gc.diff"
  end
end

case ruby_ver
when '#TODO'
  %w(some_patch.diff).each do |patch|
    cookbook_file "#{cache}/#{patch}"
  end

  execute 'Install patches' do
    command 'echo yay, all done'
    action :nothing
    subscribes :run, 'execute[Extract Ruby]'
  end
end
