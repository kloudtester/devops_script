maven install for springpetclinic:
----------------------------------
 * maven 3.9.0 version refer link 
 [refer her ] https://linuxhint.com/install_apache_maven_ubuntu/

steps:
------
```
wget https://downloads.apache.org/maven/maven-3/3.9.0/binaries/apache-maven-3.9.0-bin.tar.gz -P /tmp
sudo apt install openjdk-17-jdk -y
 cd /tmp
 tar -xvzf apache-maven-3.9.0-bin.tar.gz
 sudo cp -r apache-maven-3.9.0 /opt/maven
 sudo nano /etc/profile.d/maven.sh
export JAVA_HOME=/usr/lib/jvm/java-1.17.0-openjdk-amd64
export M2_HOME=/opt/maven
export MAVEN_HOME=/opt/maven
export PATH=${M2_HOME}/bin:${PATH}
sudo chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
```