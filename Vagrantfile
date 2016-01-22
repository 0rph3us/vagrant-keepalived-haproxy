# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"


  config.vm.define :lb1 do |node|
    node.vm.hostname = "lb1.vagrant"
    node.vm.network :private_network, ip: "192.168.10.50"
  end

  config.vm.define :lb2 do |node|
    node.vm.hostname = "lb2..vagrant"
    node.vm.network :private_network, ip: "192.168.10.51"
  end

  config.vm.define :webserver1 do |node|
    node.vm.hostname = "webserver1.vagrant"
    node.vm.network :private_network, ip: "192.168.10.21"
  end

  config.vm.define :webserver2 do |node|
    node.vm.hostname = "webserver2.vagrant"
    node.vm.network :private_network, ip: "192.168.10.22"
  end

  config.vm.define :webserver3 do |node|
    node.vm.hostname = "webserver3..vagrant"
    node.vm.network :private_network, ip: "192.168.10.23"
  end

  config.vm.provision :shell do |shell|
    shell.inline = "mkdir -p /etc/puppet/modules;
                    gem install r10k &&
                    cd /vagrant &&
                    r10k -v info puppetfile install"
  end

  config.vm.provision :puppet, :options => ["--verbose", "--modulepath=/etc/puppet/modules:/vagrant/modules"] do |puppet|

  end

end
