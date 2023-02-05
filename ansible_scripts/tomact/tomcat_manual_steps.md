Installing_tomcat_on ubuntu:
----------------------------

* First we need to install java on ubuntu and update the machine
```
sudo apt install openjdk-11-jdk
sudo apt update
```
* next we need to create group and user for tomcat
* next we also want to create the sheel and home directory to that user commmand to this is 
```
sudo useradd -g tomcat -d /opt/tomcat -s -U /bin/false tomcat 
here
-d means home directory
-g group
-s shell
-U user
``` 
* next we need to download the tomcat file for this we need wget and tomact file link
```
sudo apt install wget 
sudo wget ://www-eu.apache.org/dist/tomcat/tomcat-{{ tomcat_major_version }}/v{{ tomcat_version }}/bin/apache-tomcat-{{ tomcat_version }}.tar.gz
```  
*next we want to unzip that file by using this command 
```
sudo apt install unzip 
sudo tar -xvzf <tomcat file link>
```
* next we want move the tomcat file to the your created folder
```
sudo mv <tomcat file> /opt/tomcat/
```
* next we want create the symbolic link for the tomcat folder
```
sudo ln -s /opt/tomcat/apache-tomcat-${VERSION} /opt/tomcat/latest
```
* next we want to change the ownership permission to home directory
```
sudo chown -R tomcat: /opt/tomcat <here -r means creating a system account>
```
* In tomcat folder we have bin folder in that we have some executable file we need to give them execute permission so use this command 
  ```
  sudo sh -c 'chmod +x {{ user_home }}/latest/bin/*.sh'
  ```
* now we need to create a tomcat servcie file
```
[Unit]
Description=Tomcat 10 servlet container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom -Djava.awt.headless=true"

Environment="CATALINA_BASE=/opt/tomcat/latest"
Environment="CATALINA_HOME=/opt/tomcat/latest"
Environment="CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

[Install]
WantedBy=multi-user.target

```
* next we need to sens this file to some destination in tomact
```
/etc/systemd/system/tomcat.service
```
* next we also need to edit the tomcat-user.xml file
* file with your text editor and create a new user, as shown below
```
<tomcat-users>
<!--
    Comments
-->
   <role rolename="admin-gui"/>
   <role rolename="manager-gui"/>
   <user username="admin" password="admin_password" roles="admin-gui,manager-gui"/>
</tomcat-users>

```
* this tomcat-user.xml file will present in this file system
```
 /opt/tomcat/latest/conf/tomcat-users.xml
```
* next we need to edit the Manager app to access it 
```
<Context antiResourceLocking="false" privileged="true" >
<!--
  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />
-->
</Context>
```
* this file systemctl is present in 
```
 /opt/tomcat/latest/webapps/manager/META-INF/context.xml
```
* we need to restart the tomcat 
```
sudo systemctl restart tomcat
```