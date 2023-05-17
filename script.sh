#!/bin/bash

sudo apt-get update
sudo apt install default-jre -y 
sudo apt-get update 
sudo apt install default-jdk -y 
sudo apt-get update

curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y

sudo systemctl start jenkins
sudo systemctl enable jenkins
# sudo systemctl status jenkins

# ouvrir les ports requis

# sudo ufw allow 8080
# sudo ufw status
# sudo ufw allow OpenSSH 
# sudo ufw enable
# sudo ufw enable


sudo apt-get install maven -y
sudo apt-get update
sudo apt-get install docker.io -y
sudo usermod -a -G docker jenkins
echo "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64" >> ~/.bashrc
echo "export MAVEN_HOME=/usr/share/maven" >> ~/.bashrc



