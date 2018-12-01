# -*- mode: ruby -*-
# vi: set ft=ruby :
#
Vagrant.configure("2") do |config|
  config.vm.define "centos" do |centos|
    centos.vm.box = "centos/7"
    # centos.vm.network "private_network", ip: "192.168.33.10"
    centos.vm.network "public_network"
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
  end

  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "ubuntu/bionic64"
    # ubuntu.vm.network "private_network", ip: "192.168.33.20"
    ubuntu.vm.network "public_network"
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
  end
end
