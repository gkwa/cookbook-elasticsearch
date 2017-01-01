VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Don't keep reinstalling virtualbox guest additions, it takes too
  # much time
  if Vagrant.has_plugin?('vagrant-vbguest')
    config.vbguest.auto_update = false
  end

  # Cache the chef client omnibus installer to speed up testing
  if Vagrant.has_plugin?("vagrant-omnibus")
    config.omnibus.cache_packages = true
  end
end
