
remote_file File.join('/', 'tmp', File.basename(node[:ruby_installer][:ree_url])) do
  source node[:ruby_installer][:ree_url]
  not_if{ ::File.exists?(File.basename(node[:ruby_installer][:ree_url])) }
end
bash "Install REE deb" do
  code "dpkg -i #{File.join('/', 'tmp', File.basename(node[:ruby_installer][:ree_url]))}; apt-get -f install"
  not_if{
    v = %x{ruby -v}.to_s.split(' ')
    version = "#{v[1]}-#{v.last}"
    version == node[:ruby_installer][:ree_url].scan(/_(\d+[^_]+)_/).first.first 
  }
  notifies :reload, resources(:ohai => 'ruby'), :immediately
end
