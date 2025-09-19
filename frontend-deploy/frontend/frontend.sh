#!/bin/bash
component=$1
env=$2
appVersion=$3
dnf install ansible -y
pip3.9 install botocore boto3
ansible-pull -i localhost, -U https://github.com/jeethvishnu/ansiible-infra-roles.git ansible-roles/main.yaml -e component=$component -e environment=$env -e appVersion=$appVersion