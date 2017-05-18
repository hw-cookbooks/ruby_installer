#
# Cookbook Name:: ruby_installer
# Recipe:: _ree_patch
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
ruby_ver = File.basename(node['ruby_installer']['ree_source_url']).sub('.tar.gz', '')

case ruby_ver
when 'ruby-enterprise-1.8.7-2012.02'
  %w(no_sslv2.diff ossl_pkey_ec.c_OPENSSL_FIX.patch stdout-rouge-fix.patch tcmalloc.patch).each do |patch|
    cookbook_file "#{cache}/#{patch}"
  end

  execute 'Install patches' do
    command <<-EOH
      patch -Np1 /usr/src/#{ruby_ver}/source/ext/openssl/ossl_ssl.c < #{cache}/no_sslv2.diff
      patch -Np1 /usr/src/#{ruby_ver}/source/lib/mkmf.rb < #{cache}/stdout-rouge-fix.patch
      patch -Np1 /usr/src/#{ruby_ver}/source/distro/google-perftools-1.7/src/tcmalloc.cc < #{cache}/tcmalloc.patch
      patch -Np1 /usr/src/#{ruby_ver}/source/ext/openssl/ossl_pkey_ec.c < #{cache}/ossl_pkey_ec.c_OPENSSL_FIX.patch
    EOH
    action :nothing
    subscribes :run, 'execute[Extract REE]'
  end
end
