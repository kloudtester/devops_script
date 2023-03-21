jenkins_install_steps:
----------------------

* To install jenkins follow this commands
```
sudo apt update
sudo apt install openjdk-17-jdk -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y
sudo systemctl start jenkins
``` 
* home path of the jenkins in ubuntu is
```
/var/lib/jenkins
```
* home path of the jenkins in redhat is
```
/var/lib/jenkins
```
* logs of jenkins is present in 
```
var/log/jenkins
```
* If we want to login into jenkins with another user
```
/var/lib/jenkins/config.xml
```