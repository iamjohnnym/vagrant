# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vbguest.auto_update = false
  config.vm.provider "virtualbox"
  config.vm.define :master do |master|
    master.vm.box = "bento/centos-7.1"
    master.vm.hostname = 'master'
    master.vm.network :private_network, ip: "192.168.56.201"
    master.vm.network :forwarded_port, guest: 22, host: 20211, id: "ssh"
    master.vm.synced_folder "saltstack/salt/", "/srv/salt"
    master.vm.synced_folder "saltstack/pillar/", "/srv/pillar"


    master.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 900]
      v.customize ["modifyvm", :id, "--name", "master"]
	  v.customize ["modifyvm", :id, "--cpus", 1]
	  v.linked_clone = true if Gem::Version.new(Vagrant::VERSION) >= Gem::Version.new('1.8.0')
    end

    ## Use all the defaults:
    master.vm.provision :salt do |salt|
      salt.master_config = "saltstack/etc/master"
      salt.master_key = "saltstack/keys/master_minion.pem"
      salt.master_pub = "saltstack/keys/master_minion.pub"
      salt.minion_key = "saltstack/keys/master_minion.pem"
      salt.minion_pub = "saltstack/keys/master_minion.pub"
      salt.seed_master = {
                          "minion01" => "saltstack/keys/minion01.pub",
                          "minion02" => "saltstack/keys/minion02.pub"
                         }
      salt.install_type = "stable"
      salt.install_master = true
      salt.no_minion = true
      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp"
    end

  end

  config.vm.define :minion02 do |minion|
    minion.vm.box = "bento/ubuntu-14.04"
    minion.vm.hostname = 'minion02'
    minion.vm.network :private_network, ip: "192.168.56.203"
    minion.vm.network :forwarded_port, guest: 22, host: 20213, id: "ssh"


    minion.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "minion02"]
	  v.customize ["modifyvm", :id, "--cpus", 2]
	  v.linked_clone = true if Gem::Version.new(Vagrant::VERSION) >= Gem::Version.new('1.8.0')
    end

    ## Use all the defaults:
    minion.vm.provision :salt do |salt|
      salt.minion_config = "saltstack/etc/minion02"
      salt.minion_key = "saltstack/keys/minion02.pem"
      salt.minion_pub = "saltstack/keys/minion02.pub"
      salt.install_type = "stable"
      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp"
    end
  end

  config.vm.define :minion01 do |minion|
    minion.vm.box = "bento/centos-7.1"
    minion.vm.hostname = 'minion01'
    minion.vm.network :private_network, ip: "192.168.56.202"
    minion.vm.network :forwarded_port, guest: 22, host: 20212, id: "ssh"


    minion.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "minion01"]
	  v.customize ["modifyvm", :id, "--cpus", 2]
	  v.linked_clone = true if Gem::Version.new(Vagrant::VERSION) >= Gem::Version.new('1.8.0')
    end

    ## Use all the defaults:
    minion.vm.provision :salt do |salt|
      salt.minion_config = "saltstack/etc/minion01"
      salt.minion_key = "saltstack/keys/minion01.pem"
      salt.minion_pub = "saltstack/keys/minion01.pub"
      salt.install_type = "stable"
      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp"
    end
  end
end
