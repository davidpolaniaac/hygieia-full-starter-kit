#!/bin/bash
sudo su -
yum update -y
yum install git -y
yum install maven -y
amazon-linux-extras install docker -y
yum install docker -y
service docker start
chkconfig docker on
usermod -a -G docker ec2-user
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

mkdir /hygieia
git clone --recursive https://github.com/davidpolaniaac/hygieia-full-starter-kit.git /hygieia
mvn -f /hygieia/ExecDashboard/pom.xml clean install package
mvn -f /hygieia/hygieia-cmdb-company-collector/pom.xml clean install package
echo "GITHUB_TOKEN=$GITHUB_TOKEN
CMDB_TOKEN=$CMDB_TOKEN
CMDB_PROJECTID=$CMDB_PROJECTID
CMDB_ORGANIZATIONNAME=$CMDB_ORGANIZATIONNAME" >> /hygieia/.env
cd /hygieia && docker-compose up -d --build