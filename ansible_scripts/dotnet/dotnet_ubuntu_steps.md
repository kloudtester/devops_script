Installing_steps:
----------------
First install dotnet in ubuntu 
  * [Refer] https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#2204
* commands to install dot net manually follow this command 
---
sudo apt update
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt install apt-transport-https 
sudo apt-get install -y dotnet-sdk-7.0
---
* by uaing this command you can get output like this
    * ![preview]dotnet_manaual_output_1.png


Installing_dotnet_using_ansible_playbook:
----------------------------------------
* first you need to install ansible in the master node 
---
sudo apt -y install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt install ansible -y
---
* do the config like adding user and giving sudo permission to that user 
* plyabook for installing dotnet in ubuntu
--- 
  - name: installing_dotnet_ubuntu
    become: yes
    hosts: all
    vars:
      donet_package: dotnet-sdk-6.0
    tasks:
      - name: instaiing_dotnet
        ansible.builtin.apt:
        when: ansible_facts['distribution'] == "Ubuntu"
          name: "{{ dotnet_package }}"
          update_cache: yes
          state: present
      - name: installing_donet_completed
        ansible.builtin.debug:
          msg: installing_donet_completed
---