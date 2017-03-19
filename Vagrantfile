# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "vm1" do |vm1|
    vm1.vm.box = "bento/centos-7.1"
    vm1.vm.hostname = 'centdev'

    vm1.vm.network :private_network, ip: "192.168.56.101"
    vm1.vm.network :forwarded_port, guest: 22, host: 10122, id: "ssh"


    vm1.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "centdev"]
	  v.customize ["modifyvm", :id, "--cpus", 2]
	  v.linked_clone = true if Gem::Version.new(Vagrant::VERSION) >= Gem::Version.new('1.8.0')
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
