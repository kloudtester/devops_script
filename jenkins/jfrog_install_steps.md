prerequisites for JFrog

small or medium instance t2 ytpe
2cpus
8081 and 8082 and ssh ports
openjdk 11
```
 sudo apt update
 sudo apt install openjdk-17-jdk -y
 wget -qO - https://api.bintray.com/orgs/jfrog/keys/gpg/public.key | sudo apt-key add -
 echo "deb https://jfrog.bintray.com/artifactory-debs bionic main" | sudo tee /etc/apt/sources.list.d/jfrog.list
 sudo apt update
  sudo apt install jfrog-artifactory-oss
 sudo systemctl start artifactory.service
 sudo systemctl enable artifactory.service
 systemctl status artifactory.service
```
Access Jfrog UI
Open your browser and enter http://IP_or DOMAIN-NAME:8081/artifactory

Use default username and password to loging.
admin
password

You need to reset the admin password.

Setup the base URL, like your domain name to access the JFrog artifactory web UI. You can skip if you don’t have any.

Now, the next step is to configure the default proxy. If your enterprise has a proxy gateway for accessing the server, use it otherwise skip it.

Now your installation and basic configuration is finished. You can start creating a repository based on your project.
