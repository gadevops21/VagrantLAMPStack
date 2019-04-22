#!/usr/bin/env bash

sudo apt-get update
sudo apt-get upgrade

echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen  # enable locales in `/etc/locale.gen`
update-locale LANG=en_US.UTF-8  # setup default VM locale
sed -i -E 's/^(\s*AcceptEnv\b)/#\1/' /etc/ssh/sshd_config  # avoid SSH overriding it

sudo apt-get install -y software-properties-common curl git wget

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

sudo apt-get update
sudo apt-get -y install mysql-server
sed -i "s/^bind-address/#bind-address/" /etc/mysql/my.cnf
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES; SET GLOBAL max_connect_errors=10000;"
mysql -u root -proot -e "CREATE DATABASE dev_db;"
sudo /etc/init.d/mysql restart

sudo apt install -y ca-certificates apt-transport-https 
wget -q https://packages.sury.org/php/apt.gpg -O- | sudo apt-key add -
sudo echo "deb https://packages.sury.org/php/ jessie main" | tee /etc/apt/sources.list.d/php.list
sudo apt-get update
sudo apt-get install -y apache2 php7.3 php7.3-fpm php7.3-opcache php7.3-cli php7.3-common php7.3-curl php7.3-gd php7.3-json php-xdebug php7.3-mbstring php7.3-mysql php7.3-sqlite3 php7.3-xml libapache2-mod-php7.3

sudo sed -i 's/display_errors = Off/display_errors = On/' /etc/php/7.3/apache2/php.ini
sudo sed -i 's/display_startup_errors = Off/display_startup_errors = On/' /etc/php/7.3/apache2/php.ini

curl -Ss https://getcomposer.org/installer | php
sudo mv composer.phar /usr/bin/composer

# Configure Apache

echo "<VirtualHost *:80>
    DocumentRoot /var/www/public
    AllowEncodedSlashes On
    <Directory /var/www/public>
        Options -Indexes +FollowSymLinks
        DirectoryIndex index.php index.html
        Order allow,deny
        Allow from all
        AllowOverride All
    </Directory>
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" > /etc/apache2/sites-available/000-default.conf

a2enmod rewrite
service apache2 restart

sudo rm -rf /var/www/*
sudo mkdir /var/www/public
