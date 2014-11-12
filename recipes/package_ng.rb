#
# Cookbook Name:: ruby_installer
# Recipe:: package_ng
#
# Copyright 2012, Cramer Development, Inc.
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

# This insalls Ruby using Brightbox's Next Generation Ruby packages

if node['platform'] == 'ubuntu'
  apt_repository 'ruby-ng-experimental' do
    uri 'http://ppa.launchpad.net/brightbox/ruby-ng-experimental/ubuntu'
    distribution node['lsb']['codename']
    components ['main']
    keyserver 'keyserver.ubuntu.com'
    key 'C3173AA6'
  end

  package 'ruby-switch'

  package 'ruby1.9.3' do
    notifies :reload, resources(:ohai => 'ruby'), :immediately
  end
else
  Chef::Logger.warn('The package_ng installer method only works on Ubuntu. Not installing.')
end
