RubyInstaller
=============

This cookbook provides Ruby installation from a variety of places. It also
handles ohai reloading to ensure proper ruby/gem usage.

Supports
========

Currently supporting ubuntu/debian

Usage
=====

```
knife node run_list add my.node recipe[ruby_installer]
```

Configurable attributes
=======================

* `default[:ruby_installer][:method] = 'package' # package/ree/source/pennyworth`
* `default[:ruby_installer][:package_name] = 'ruby-full' # apt package name`
* `default[:ruby_installer][:rubygem_package] = false # install rubygems package`
* `default[:ruby_installer][:source_version] = nil # source version`
* `default[:ruby_installer][:source_package_dependencies] = [] # package dependencies for building from source`
* `default[:ruby_installer][:ree_url] = 'http://rubyenterpriseedition.googlecode.com/files/ruby-enterprise_1.8.7-2012.02_amd64_ubuntu10.04.deb' # URI for REE deb package`

Notes
=====

Source installation is currently not implemented. If pennyworth installation
method is used, the pennyworth_client cookbook must be provided.

Repository
==========

https://github.com/heavywater/chef-ruby_installer
