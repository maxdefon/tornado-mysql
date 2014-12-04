apt-get update
apt-get install -y python-dev
apt-get install -y python-pip
apt-get install -y python-virtualenv
apt-get install -y python-mysqldb


echo mysql-server mysql-server/root_password select vagrant | debconf-set-selections
echo mysql-server mysql-server/root_password_again select vagrant | debconf-set-selections
apt-get install -y mysql-server
apt-get install -y libmysqlclient-dev

mysql --user=root --password=vagrant -e "CREATE USER 'vagrant'@'localhost' IDENTIFIED BY 'vagrant';"
mysql --user=root --password=vagrant -e "GRANT USAGE ON * . * TO 'vagrant'@'localhost' IDENTIFIED BY 'vagrant' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;"
mysql --user=root --password=vagrant -e "CREATE DATABASE IF NOT EXISTS vagrant ;"
mysql --user=root --password=vagrant -e "GRANT ALL PRIVILEGES ON vagrant . * TO 'vagrant'@'localhost';"

mysql --user=root --password=vagrant -e "CREATE USER 'redis'@'localhost' IDENTIFIED BY 'redis';"
mysql --user=root --password=vagrant -e "GRANT USAGE ON * . * TO 'redis'@'localhost' IDENTIFIED BY 'redis' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;"
mysql --user=root --password=vagrant -e "CREATE DATABASE IF NOT EXISTS redis ;"
mysql --user=root --password=vagrant -e "GRANT ALL PRIVILEGES ON redis . * TO 'redis'@'localhost';"
mysql --user=root --password=vagrant -e "CREATE TABLE TABLE itens( id int, name varchar(255));
"
mysql --user=root --password=vagrant -e "INSERT INTO itens ( id, 'name') VALUES(1, 'item-1');
"
mysql --user=root --password=vagrant -e "INSERT INTO itens ( id, 'name') VALUES(2, 'item-2');
"

apt-get install -y libfontconfig

echo "America/Sao_Paulo" | sudo tee /etc/timezone
sudo dpkg-reconfigure --frontend noninteractive tzdata

apt-get install -y nginx

cp /vagrant/vagrant_provision/nginx.site /etc/nginx/sites-available/site
ln -s /etc/nginx/sites-available/site /etc/nginx/sites-enabled/site

sed -i 's/sendfile on;/sendfile off;/' /etc/nginx/nginx.conf

echo "192.168.33.3   localhost3" >> /etc/hosts

apt-get install -y supervisor
cp /vagrant/vagrant_provision/supervisor.default.conf /etc/supervisor/conf.d/default.conf


