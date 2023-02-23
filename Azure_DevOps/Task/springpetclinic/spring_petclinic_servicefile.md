servicefile:
-----------
 * follow this commands 

```
sudo nano /etc/systemd/system/spring-petclinic.service
sudo systemctl daemon-reload
sudo systemctl start spring-petclinic.service
```
file:
----

```
[Unit]
Description=SpringPetClinic
After=network.target
[Service]
User=springpetclinic
WorkingDirectory=/home/ubuntu/
ExecStart=/usr/lib/jvm/java-1.17.0-openjdk-amd64/bin/java -jar  /home/ubuntu/spring-petclinic-3.0.0-SNAPSHOT.jar
SuccessExitStatus=143
Restart=always
[Install]
WantedBy=multi-user.target
```
anotherfile:
-----------

```
[Unit]
Description=SpringPetClinic
[Service]
ExecStart=/usr/lib/jvm/java-1.17.0-openjdk-amd64/bin/java -jar  /home/sai/spring-petclinic-3.0.0-SNAPSHOT.jar
[Install]
WantedBy=multi-user.target
```