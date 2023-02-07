Openmrs_installing_steps_on ubuntu:
-----------------------------------

* installing openmrs on ubuntu we need java package on it 
```
sudo apt-get install openjdk-8-jdk -y
```
* Install MySQL Server 5.6
* First create a user and group for MySQL using the following command
```
sudo groupadd mysql
sudo useradd -g mysql mysql
```
* Next download MySQL 5.6 source with the following command
```
sudo wget https://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.46-linux-glibc2.12-x86_64.tar.gz
```
* Once the MySQL is downloaded extract it with the following command
```
tar -xvf mysql-5.6.46-linux-glibc2.12-x86_64.tar.gz
```
* Next move the extracted directory to /usr/local with the following command
```
sudo mv mysql-5.6.46-linux-glibc2.12-x86_64 /usr/local/mysql
```
* navigate to the /usr/local directory and set proper ownership with the following command
```
cd /usr/local/mysql
chown -R mysql:mysql *
```
* Next, install the required dependencies using the following command
```
sudo apt-get install libaio1 libncurses5 libnuma-dev -y
```