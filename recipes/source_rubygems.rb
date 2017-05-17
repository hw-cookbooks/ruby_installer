rubygem_ver = node['ruby_installer']['source_rubygems_version']
bin_dir = "#{node['ruby_installer']['source_install_dir']}/bin"

remote_file "/usr/src/rubygems-#{rubygem_ver}.tgz" do
  source "http://production.cf.rubygems.org/rubygems/rubygems-#{rubygem_ver}.tgz"
  action :create_if_missing
  not_if { Mixlib::ShellOut.new("#{bin_dir}/gem --version").run_command.stdout.include?(rubygem_ver) }
end

bash 'install_rubygems' do
  cwd '/usr/src'
  code <<-EOH
    tar -zxf rubygems-#{rubygem_ver}.tgz
    cd rubygems-#{rubygem_ver}
    #{bin_dir}/ruby setup.rb
  EOH
  not_if { Mixlib::ShellOut.new("#{bin_dir}/gem --version").run_command.stdout.include?(rubygem_ver) }
end
