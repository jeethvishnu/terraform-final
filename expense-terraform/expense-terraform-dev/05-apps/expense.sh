#!/bin/bash
#user data will get sudo access defaultly
dnf install ansible -y
cd /tmp
git clone https://github.com/jeethvishnu/expense-ansible-roles.git
cd expense-ansible-roles
ansible-playbook main.yaml -e component=backend -e login_password=ExpenseApp1
ansible-playbook main.yaml -e component=frontend
