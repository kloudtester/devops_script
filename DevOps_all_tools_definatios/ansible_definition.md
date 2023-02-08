Ansible:
------- 
 * IT automation tool for automating cloud provisioning, configuration management, and application deployment.

![preview](C:\Users\pamid\OneDrive\Desktop\devops_script\DevOps_all_tools_definatios\ansible_mindmap\ansible-1.png)


Sub-topics:
----------
 * Playbooks, Modules, Inventory, Variables, Tasks, Roles, Templates, Facts.

Ansible Playbook:
---------------- 
 * A file written in YAML format, used to define workflows executed by Ansible.

Modules:
-------
 * Pre-written code snippets that can be used to perform specific tasks in Ansible playbooks.

Inventory: 
---------
 * File or script defining the list of target systems for Ansible to manage.

Tasks:
------
 * Units of action in an Ansible playbook that perform specific operations on managed systems.

Roles:
-----
 * A way to organize and reuse Ansible tasks and playbooks.

Templates:
---------
 * Ansible templates use Jinja2 syntax to create dynamic content from variables.

Facts:
------
 * Variables automatically gathered by Ansible from managed systems, used to inform playbook execution.

Static Inventory: 
----------------
 * This is a simple text file that lists all the hosts that Ansible will manage. It is created and managed manually, and the contents do not change unless modified by the user.

Dynamic Inventory:
------------------
 * This type of inventory is generated dynamically at runtime based on external data sources like AWS, GCP, or a database. It allows Ansible to manage a large number of hosts automatically and dynamically.
  
Parallelism:
------------
 * Parallelism allows Ansible to run multiple tasks simultaneously on different hosts.
  
Serial:
-------
 * Serial allows Ansible to run tasks one-by-one in a serial manner, rather than in parallel. This is useful when certain tasks must be executed in a specific order, or when a task must be executed on only one host at a time. 

Ansible Conditions:
-------------------
 * Ansible allows you to use conditions in your playbooks to control the execution of tasks based on certain conditions. There are several conditional statements available in Ansible, such as when, failed_when, changed_when, and register.
  
Ansible Loops:
----------------
 * In Ansible, loops are used to repeat a task multiple times with different values. Loops can be used in playbooks and templates to perform actions on multiple items in a list or dictionary.

There are two types of loops in Ansible:

with_items:
-----------
*  used to loop over a list of items, with each iteration using the current item in the list.
with_dict:
----------
*  used to loop over the items in a dictionary, with each iteration using the key and value of the current item.

Ansible Forks:
--------------
 * In Ansible, the forks setting controls the number of parallel or simultaneous tasks that can be executed on the target hosts.

Ansible Looksups:
-----------------
 * Ansible lookups are a feature that allow you to retrieve values from external data sources.
example:
```yml
- name: Use contents of a file
  debug:
    msg: "{{ lookup('file', '/path/to/file') }}"

```

Ansible Tags:
-------------
 * Tags in Ansible are a way to organize and control the execution of tasks in a playbook. Tasks can be assigned one or more tags, and when a playbook is executed, only tasks with specified tags will be run.

Ansible Vaults:
---------------
 * Ansible Vaults are a feature that allow you to store sensitive information, such as passwords or secret keys, securely in your playbooks. The information is encrypted using AES 256-bit encryption and can only be decrypted using a vault password.

Ansible Handlers:
-----------------
 * Ansible handlers are a type of task in Ansible that are used to trigger actions based on the state of other tasks.

Ansible Flush Handlers:
-----------------------
 * Ansible handlers are like special tasks that only run if notified by other tasks. "Flushing" handlers means telling Ansible to run these special tasks if they have been notified. In simple terms, flushing handlers means executing the tasks that have been marked to run only under certain conditions.

