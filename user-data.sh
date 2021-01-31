#!/bin/bash
sudo su -

sysctl -w vm.max_map_count=262144
sysctl -w fs.file-max=65536
ulimit -n 65536
ulimit -u 4096

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
JENKINS_SERVER=$JENKINS_SERVER
SONAR_SERVER=$SONAR_SERVER
SONAR_USER=$SONAR_USER
SONAR_PASSWORD=$SONAR_PASSWORD
AZ_TOKEN=$AZ_TOKEN
AZ_PROJECT=$AZ_PROJECT
AZ_ORGANIZATION_NAME=$AZ_ORGANIZATION_NAME" >> /hygieia/.env
cd /hygieia && docker-compose up -d --build