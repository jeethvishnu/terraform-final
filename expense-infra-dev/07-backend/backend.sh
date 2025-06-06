#!/bin/bash
component=$1
env=$2
dnf install ansible -y
pip3.9 install botocore boto3
ansible pull -i localhost, -U https://github.com/jeethvishnu/ansiible-infra-roles.git main.yaml -e component=$component -e environment=$env