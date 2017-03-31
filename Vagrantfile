# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define :master do |master|
    master.vm.box = "bento/centos-7.1"
    master.vm.hostname = 'master'
    master.vm.network :private_network, ip: "192.168.56.201"
    master.vm.network :forwarded_port, guest: 22, host: 20122, id: "ssh"
    master.vm.synced_folder "saltstack/salt/", "/srv/salt"
    master.vm.synced_folder "saltstack/pillar/", "/srv/pillar"


    master.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
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
                          "minion1" => "saltstack/keys/minion1.pub",
                          "minion2" => "saltstack/keys/minion2.pub"
                         }
      salt.install_type = "stable"
      salt.install_master = true
      salt.no_minion = true
      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp"
    end

    config.vm.provision "shell", inline: <<-SHELL
      sudo yum update -y
      sudo yum groupinstall 'Development Tools'
      sudo yum install -y python-virtualenv git libffi libffi-devel python-devel gcc paramiko PyYAML Jinja2 httplib2 six openssl-devel 
      sudo useradd -m -G wheel -s /bin/bash dev
      sudo perl -p -i -e "s|^%wheel|#%wheel|" ~/etc/sudoers
      sudo perl -p -i -e "s|^# %wheel|%wheel|" ~/etc/sudoers
      sudo -u dev -i /bin/bash -l -c 'virtualenv ~/.venv'
      sudo -u dev -i /bin/bash -l -c 'echo "source ~/.venv/bin/activate" >> ~/.bash_profile'
      sudo -u dev -i /bin/bash -l -c 'git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle/'
      sudo -u dev -i /bin/bash -l -c 'source ~/.venv/bin/activate'
      sudo -u dev -i /bin/bash -l -c '/home/dev/.venv/bin/pip install ansible boto3' 
    SHELL
  end

  config.vm.define :minion01 do |minion|
    minion.vm.box = "bento/centos-7.1"
    minion.vm.hostname = 'minion01'
    minion.vm.network :private_network, ip: "192.168.56.202"
    minion.vm.network :forwarded_port, guest: 22, host: 20222, id: "ssh"


    minion.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "minion01"]
	  v.customize ["modifyvm", :id, "--cpus", 2]
	  v.linked_clone = true if Gem::Version.new(Vagrant::VERSION) >= Gem::Version.new('1.8.0')
    end

    ## Use all the defaults:
    minion.vm.provision :salt do |salt|
      salt.minion_config = "saltstack/etc/minion1"
      salt.minion_key = "saltstack/keys/minion1.pem"
      salt.minion_pub = "saltstack/keys/minion1.pub"
      salt.install_type = "stable"
      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp"
    end

    config.vm.provision "shell", inline: <<-SHELL
      sudo yum update -y
      sudo yum groupinstall 'Development Tools'
      sudo yum install -y python-virtualenv git libffi libffi-devel python-devel gcc paramiko PyYAML Jinja2 httplib2 six openssl-devel 
      sudo useradd -m -G wheel -s /bin/bash dev
      sudo perl -p -i -e "s|^%wheel|#%wheel|" ~/etc/sudoers
      sudo perl -p -i -e "s|^# %wheel|%wheel|" ~/etc/sudoers
      sudo -u dev -i /bin/bash -l -c 'virtualenv ~/.venv'
      sudo -u dev -i /bin/bash -l -c 'echo "source ~/.venv/bin/activate" >> ~/.bash_profile'
      sudo -u dev -i /bin/bash -l -c 'git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle/'
      sudo -u dev -i /bin/bash -l -c 'source ~/.venv/bin/activate'
      sudo -u dev -i /bin/bash -l -c '/home/dev/.venv/bin/pip install ansible boto3' 
    SHELL
  end

  config.vm.define :minion02 do |minion|
    minion.vm.box = "bento/centos-7.1"
    minion.vm.hostname = 'minion02'
    minion.vm.network :private_network, ip: "192.168.56.203"
    minion.vm.network :forwarded_port, guest: 22, host: 20223, id: "ssh"


    minion.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "minion02"]
	  v.customize ["modifyvm", :id, "--cpus", 2]
	  v.linked_clone = true if Gem::Version.new(Vagrant::VERSION) >= Gem::Version.new('1.8.0')
    end

    ## Use all the defaults:
    minion.vm.provision :salt do |salt|
      salt.minion_config = "saltstack/etc/minion2"
      salt.minion_key = "saltstack/keys/minion1.pem"
      salt.minion_pub = "saltstack/keys/minion1.pub"
      salt.install_type = "stable"
      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp"
    end

    config.vm.provision "shell", inline: <<-SHELL
      sudo yum update -y
      sudo yum groupinstall 'Development Tools'
      sudo yum install -y python-virtualenv git libffi libffi-devel python-devel gcc paramiko PyYAML Jinja2 httplib2 six openssl-devel 
      sudo useradd -m -G wheel -s /bin/bash dev
      sudo perl -p -i -e "s|^%wheel|#%wheel|" ~/etc/sudoers
      sudo perl -p -i -e "s|^# %wheel|%wheel|" ~/etc/sudoers
      sudo -u dev -i /bin/bash -l -c 'virtualenv ~/.venv'
      sudo -u dev -i /bin/bash -l -c 'echo "source ~/.venv/bin/activate" >> ~/.bash_profile'
      sudo -u dev -i /bin/bash -l -c 'git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle/'
      sudo -u dev -i /bin/bash -l -c 'source ~/.venv/bin/activate'
      sudo -u dev -i /bin/bash -l -c '/home/dev/.venv/bin/pip install ansible boto3' 
    SHELL
  end
end
