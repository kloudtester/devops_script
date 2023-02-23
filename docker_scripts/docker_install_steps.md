Docker_install_steps:
---------------------

* follow this commands to install docker 

```
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```
* Next we want to add user to docker group use this command to add the user to the docker group
  
```
sudo usermod -aG docker <user user name>
```
