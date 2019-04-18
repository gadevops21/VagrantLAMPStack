# VagrantLAMPStack

Vagrant LAMP development stack running on **debian/jessie64**.
## Features
### Installed packages
* apache2
* mysql
* php7.3 
    * php7.3-fpm
    * php7.3-opcache
    * php7.3-common
    * php7.3-cli
    * php7.3-curl
    * php7.3-gd
    * php7.3-json
    * php7.3-mbstring
    * php7.3-mysql
    * php7.3-sqlite3
    * php7.3-xml
    * libapache2-mod-php7.3
    * php-xdebug

## Requirements
* VirtualBox
* Vagrant >= 2.0.0

## Installation
```sh
git clone https://github.com/kczechowski/VagrantLAMPStack.git
vagrant up
```
If you want to use synced folder enable it in Vagrantfile:
```ruby
# ...
config.vm.synced_folder "./public", "/var/www/public", disabled: false
# ...
```
## Default config
### VM
```ruby
VM_IP = '10.10.10.10'
APACHE_HOST_PORT = '80'
MYSQL_HOST_PORT = '3306'
```

### mysql
```php
$dbhost = localhost
$dbuser = 'root'
$dbpassword = 'root'
```
Use **10.10.10.10:3306** as a host outside the VM.
