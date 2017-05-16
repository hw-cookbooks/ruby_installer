include_recipe 'build-essential'
ruby_ver = node['ruby_installer']['source_version']

node['ruby_installer']['source_package_dependencies'].each do |pkg|
  package pkg
end

remote_file "/usr/src/ruby-#{ruby_ver}.tar.gz" do
  source "http://ftp.ruby-lang.org/pub/ruby/#{ruby_ver[0..2]}/ruby-#{ruby_ver}.tar.gz"
  action :create_if_missing
end

bash 'install_ruby' do
  cwd '/usr/src'
  code <<-EOH
    tar -zxf ruby-#{ruby_ver}.tar.gz
    cd ruby-#{ruby_ver}/
    autoconf
    #{if node['ruby_installer']['source_falcon_patch']
        'curl https://raw.github.com/gist/4136373/falcon-gc.diff | patch -p1'
      end}
    ./configure --prefix=#{node['ruby_installer']['source_install_dir']} --disable-install-doc --enable-shared
    make -j#{node['cpu']['total'] + 1}
    make install
  EOH
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
