#
# Cookbook Name:: ruby_installer
# Recipe:: _source_patch
#
# Copyright (C) 2017 SpinDance, Inc.
#
# All rights reserved - Do Not Redistribute
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
