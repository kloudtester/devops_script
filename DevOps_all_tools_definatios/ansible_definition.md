Ansible:
------- 
 * IT automation tool for automating cloud provisioning, configuration management, and application deployment.

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