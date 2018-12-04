# -*- mode: ruby -*-
# vi: set ft=ruby :
#
Vagrant.configure("2") do |config|
  config.vm.define "wikijs" do |centos|
    wikijs.vm.box = "centos/7"
    # wikijs.vm.network "private_network", ip: "192.168.33.10"
    wikijs.vm.network "public_network"
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
  end

  config.vm.define "mariadb" do |ubuntu|
    mariadb.vm.box = "ubuntu/bionic64"
    # mariadb.vm.network "private_network", ip: "192.168.33.20"
    mariadb.vm.network "public_network"
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
  end
end
