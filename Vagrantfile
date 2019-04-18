# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

VM_IP = '10.10.10.10'
APACHE_HOST_PORT = '80'
MYSQL_HOST_PORT = '3306'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian/jessie64"
  config.vm.network "private_network", ip: VM_IP
  config.vm.network :forwarded_port, guest: 80, host: APACHE_HOST_PORT
  config.vm.network :forwarded_port, guest: 3306, host: MYSQL_HOST_PORT
  config.vm.provision :shell, :path => "script.sh"
  config.vm.synced_folder "./public", "/var/www/public", disabled: true
end