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

  config.vm.provision "shell", inline: <<-SHELL
	sudo sh -c 'echo network.host: 0.0.0.0 >>/etc/elasticsearch/elasticsearch.yml'
    sudo service elasticsearch restart

    sudo apt-get install --yes kibana
    sudo sed -i.bak "s/^#server.host: \"localhost\"/server.host: \"0.0.0.0\"/" /etc/kibana/kibana.yml
	sudo sed -i.bak "s/^#elasticsearch.username: .*/elasticsearch.username: \"elastic\"/" /etc/kibana/kibana.yml
    sudo sed -i.bak "s/^#elasticsearch.password: .*/elasticsearch.password: \"changeme\"/" /etc/kibana/kibana.yml
    sudo service kibana restart

    sudo service elasticsearch restart
    sudo service kibana restart
  SHELL
end
