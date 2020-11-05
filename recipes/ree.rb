
case node['platform_family']
when 'debian'
  remote_file File.join('/', 'tmp', File.basename(node['ruby_installer']['ree_url'])) do
    source node['ruby_installer']['ree_url']
    not_if { ::File.exist?(File.join('/', 'tmp', File.basename(node['ruby_installer']['ree_url']))) }
  end
  bash 'Install REE deb' do
    code "dpkg -i #{File.join('/', 'tmp', File.basename(node['ruby_installer']['ree_url']))}; apt-get -f install"
    not_if do
      begin
        v = `ruby -v`.to_s.split(' ')
      rescue Errno::ENOENT
        v = []
      end
      version = "#{v[1]}-#{v.last}"
      version == node['ruby_installer']['ree_url'].scan(/_(\d+[^_]+)_/).first.first
    end
    notifies :reload, 'ohai[ruby]', :immediately
  end
when 'fedora', 'rhel'
  build_essential 'install compilation tools'
  package %w(readline-devel openssl-devel patch)

  remote_file "/usr/src/#{File.basename(node['ruby_installer']['ree_source_url'])}" do
    source node['ruby_installer']['ree_source_url']
    not_if do
      ::File.exist?("/usr/src/#{File.basename(node['ruby_installer']['ree_source_url'])}")
    end
  end

  execute 'Extract REE' do
    cwd '/usr/src'
    command "tar xvzf #{File.basename(node['ruby_installer']['ree_source_url'])}"
    not_if do
      begin
        v = `ruby -v`.to_s.split(' ')
      rescue Errno::ENOENT
        v = []
      end
      version = "#{v[1]}-#{v.last}"
      !File.exist?("/usr/src/#{File.basename(node['ruby_installer']['ree_source_url'])}") ||
        version == node['ruby_installer']['ree_url'].scan(/_(\d+[^_]+)_/).first.first
    end
  end

  execute 'Install REE' do
    cwd "/usr/src/#{File.basename(node['ruby_installer']['ree_source_url']).sub('.tar.gz', '')}"
    command './installer --auto=/usr/local/bin'
    action :nothing
    subscribes :run, 'execute[Extract REE]'
    notifies :reload, 'ohai[ruby]', :immediately
  end

  file '/etc/profile.d/ree_path' do
    content 'export PATH=/usr/local/bin:$PATH'
    mode '755'
  end
else
  raise 'Currently unsupported platform'
end
