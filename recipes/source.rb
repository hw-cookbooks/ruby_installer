Array(node[:ruby_installer][:source_package_dependencies]).each do |pkg|
  package pkg
end

remote_file "/tmp/ruby-#{node[:ruby_installer][:source_version]}.tar.gz" do
  not_if "/usr/local/bin/ruby --version | grep -q '#{node[:ruby_installer][:source_version]}'"
  source "http://ftp.ruby-lang.org/pub/ruby/#{node[:ruby_installer][:source_version][0..2]}/ruby-#{node[:ruby_installer][:source_version]}.tar.gz"
  notifies :run, "bash[install_ruby]", :immediately
end

bash "install_ruby" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar -zxf ruby-#{node[:ruby_installer][:source_version]}.tar.gz
    (cd ruby-#{node[:ruby_installer][:source_version]}/ && ./configure && make -j#{node[:cpu][:total]+1} && make install)
    rm -Rf /tmp/ruby-#{node[:ruby_installer][:source_version]}; rm -f /tmp/ruby-#{node[:ruby_installer][:source_version]}.tar.gz
  EOH
  action :nothing
end
