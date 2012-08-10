Array(node[:ruby_installer][:source_package_dependencies]).each do |pkg|
  package pkg
end

bash "install_ruby" do
  cwd "/usr/src"
  code <<-EOH
    tar -zxf ruby-#{node[:ruby_installer][:source_version]}.tar.gz
    cd ruby-#{node[:ruby_installer][:source_version]}/
    autoconf
    ./configure --prefix=#{node[:ruby_installer][:source_install_dir]} --disable-instal-doc --enable-shared
    make -j#{node[:cpu][:total]+1}
    make install
  EOH
  action :nothing
end

remote_file "/usr/src/ruby-#{node[:ruby_installer][:source_version]}.tar.gz" do
  not_if do
    begin
      v = %{#{File.join(node[:ruby_installer][:source_install_dir], 'bin', 'ruby')} --version}.strip
      v.split(' ')[1] == node[:ruby_installer][:source_version].sub('-', '')
    rescue Errno::ENOENT
      false
    end
  end
  source "http://ftp.ruby-lang.org/pub/ruby/#{node[:ruby_installer][:source_version][0..2]}/ruby-#{node[:ruby_installer][:source_version]}.tar.gz"
  notifies :run, "bash[install_ruby]", :immediately
end

rin_ver = Gem::Version.new(node[:ruby_installer][:source_version].match(/(\d+\.?){2,3}/).to_s)

if(rin_ver < Gem::Version.new('1.9.0') || node[:ruby_installer][:source_rubygems_force])

  bash 'install_rubygems' do
    cwd "/usr/src"
    command <<-EOH
      tar -zxf rubygems-#{node[:ruby_installer][:source_rubygems_version]}.tgz
      cd rubygems-#{node[:ruby_installer][:source_rubygems_version]}
      #{File.join(node[:ruby_installer][:source_install_dir], 'bin', 'ruby')} setup.rb
    EOH
    action :nothing
  end

  remote_file "/usr/src/rubygems-#{node[:ruby_installer][:source_rubygems_version]}.tgz" do
    source "http://production.cf.rubygems.org/rubygems/rubygems-#{node[:ruby_installer][:source_rubygems_version]}.tgz"
    not_if do
      begin
        v = %x{#{File.join(node[:ruby_installer][:source_install_dir], 'bin', 'gem')} --version}.strip
        v == node[:ruby_installer][:source_rubygems_version]
      rescue Errno::ENOENT
        false
      end
    end
    notifies :run, 'bash[install_rubygems]', :immediately
  end
end
