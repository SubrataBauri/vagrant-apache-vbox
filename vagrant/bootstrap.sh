#!/bin/bash

echo "Provisioning virtual machine..."
echo "=========================================="
echo "Updating Ubuntu"
sudo apt-get update -y > /dev/null
sudo apt-get autoclean -y > /dev/null
sudo apt-get -f install -y > /dev/null
sudo apt-get upgrade -y > /dev/null
sudo apt-get dist-upgrade -y > /dev/null

# Apache
echo "Installing Apache"
sudo apt-get install apache2 -y > /dev/null

# PHP
echo "Updating PHP repository"
sudo apt-get install python-software-properties -y > /dev/null
sudo add-apt-repository ppa:ondrej/php -y > /dev/null
sudo apt-get update -y > /dev/null

echo "Installing PHP"
sudo apt-get install php7.1 -y > /dev/null

echo "Installing PHP extensions"
sudo apt-get install php7.1-common php7.1-dev php5-cli php7.1-fpm -y > /dev/null
sudo apt-get install -y libapache2-mod-php7.1 php7.1-cli php7.1-common php7.1-mbstring -y > /dev/null
sudo apt-get install -y php7.1-gd php7.1-intl php7.1-xml php7.1-mysql -y > /dev/null
sudo apt-get install -y php7.1-mcrypt php7.1-zip php7.1-bcmath php7.1-xdebug -y > /dev/null
sudo apt install php7.1-curl -y > /dev/null
sudo apt install php7.1-soap -y > /dev/null
sudo apt-get install curl unzip -y > /dev/null
sudo service apache2 restart > /dev/null

# MySQL 
echo "Preparing MySQL"
sudo apt-get install debconf-utils -y > /dev/null
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"

echo "Installing MySQL"
sudo apt-get install mysql-server-5.6 -y > /dev/null
sudo apt-get install mysql-server -y -f > /dev/null
sudo apt-get install -y mysql-client > /dev/null


# Apache Configuration
echo "Configuring Apache"
sudo cp /var/www/html/config/servername.conf /etc/apache2/conf-available/servername.conf > /dev/null
sudo a2enconf servername > /dev/null
sudo cp /var/www/html/config/dir.conf /etc/apache2/mods-enabled/dir.conf > /dev/null

echo "Enable rewrite"
sudo a2enmod rewrite
sudo cp /var/www/html/config/000-default.conf /etc/apache2/sites-available/000-default.conf > /dev/null
sudo service apache2 restart > /dev/null


# Install Git
echo "Installing Git"
sudo apt-get install git -y > /dev/null

# Installing Composer
echo "Installing Composer"
curl -sS https://getcomposer.org/installer -o composer-setup.php > /dev/null
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer > /dev/null

# Installing Node
echo "Installing Node"
sudo curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh > /dev/null
sudo bash nodesource_setup.sh > /dev/null
sudo apt-get install nodejs -y --force-yes > /dev/null
sudo apt-get install build-essential -y > /dev/null

echo "Installing Bower"
sudo npm install bower -g -y > /dev/null

echo "Installing Gulp"
sudo npm install -g gulp -y > /dev/null

echo "Install Memcached"
sudo apt-get update -y > /dev/null
sudo apt install memcached -y > /dev/null
sudo apt install php-memcached -y > /dev/null
sudo service memcached restart
sudo service php7.1-fpm restart

echo "Finished provisioning."
