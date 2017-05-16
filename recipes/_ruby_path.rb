file '/etc/profile.d/ruby_path.sh' do
  content "export PATH=#{node['ruby_installer']['source_install_dir']}/bin:$PATH"
  mode '0644'
  only_if { node['ruby_installer']['set_path?'] }
end
