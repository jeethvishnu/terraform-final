#!/bin/bash
cat <<EOF >> /etc/yum.repos.d/Jenkins.repo
[jenkins]
name=Jenkins
baseurl=http://pkg.jenkins.io/redhat
gpgcheck=1
EOF
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum install fontconfig java-21-openjdk jenkins -y
systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins