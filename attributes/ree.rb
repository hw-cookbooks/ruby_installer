#
# Cookbook Name:: ruby_installer
# Attributes:: ree
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

default['ruby_installer']['ree_url'] = 'https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/rubyenterpriseedition/ruby-enterprise_1.8.7-2012.02_amd64_ubuntu10.04.deb'
default['ruby_installer']['ree_source_url'] = 'https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/rubyenterpriseedition/ruby-enterprise-1.8.7-2012.02.tar.gz'
default['ruby_installer']['ree_package_dependencies'] = value_for_platform_family(
  %w(rhel fedora) => %w(readline readline-devel zlib zlib-devel libxml2-devel libxslt-devel libyaml-devel libffi-devel openssl-devel bzip2 autoconf libtool bison),
  'debian' => %w(openssl libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison)
)
