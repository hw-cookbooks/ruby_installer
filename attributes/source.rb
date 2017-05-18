#
# Cookbook Name:: ruby_installer
# Attributes:: source
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

default['ruby_installer']['source_version'] = '1.9.3-p551'
default['ruby_installer']['source_install_dir'] = '/usr/local'
default['ruby_installer']['source_rubygems_version'] = '1.8.24'
default['ruby_installer']['source_rubygems_force'] = false
default['ruby_installer']['source_optimize'] = false
default['ruby_installer']['source_optimization_level'] = 1
default['ruby_installer']['source_falcon_patch'] = false
default['ruby_installer']['source_package_dependencies'] = value_for_platform_family(
  %w(rhel fedora) => %w(readline readline-devel zlib zlib-devel libyaml-devel libffi-devel openssl-devel bzip2 autoconf libtool bison),
  'debian' => %w(openssl libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison)
)
