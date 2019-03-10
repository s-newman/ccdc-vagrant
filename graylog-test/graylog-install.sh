#!/bin/bash
#------------------------------------------------------------------------------
# NAME
#	graylog-install - a Graylog Server installation script
#
# DESCRIPTION
#   This script was written for and tested on Ubuntu 16.04. It was written
#   based on the guide found in the official Graylog documentation:
#   <http://docs.graylog.org/en/3.0/pages/installation/os/ubuntu.html>
#
# AUTHOR
#	Written by Sean Newman.
#	Source code hosted at <https://github.com/s-newman/vagrantfiles>
#
#------------------------------------------------------------------------------

###
#   PREREQUISITES
###
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install \
    apt-transport-https \
    openjdk-8-jre-headless \
    uuid-runtime \
    pwgen

###
#   MONGODB
###
# Add MongoDB repository
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
sudo apt-get update

# Install MongoDB
sudo apt-get install -y mongodb-org

# Enable the MongoDB service
sudo systemctl daemon-reload
sudo systemctl enable mongod.service
sudo systemctl restart mongod.service

###
#   ELASTICSEARCH
###
# Add Elastic repository
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/oss-6.x/apt stable main" | sudo tee /etc/apt/source.list.d/elastic-6.x.list
sudo apt-get update

# Install Elasticsearch
sudo apt-get install -y elasticsearch-oss

# Configure Elasticsearch
sudo mv /tmp/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
sudo chown root:root /etc/elasticsearch/elasticsearch.yml
sudo chmod 440 /etc/elasticsearch/elasticsearch.yml

# Enable the Elasticsearch service
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl restart elasticsearch.service

###
#   GRAYLOG
###
# Default creds: admin:rockyou.txt-SUCKS!
# Add Graylog repository
wget https://packages.graylog2.org/repo/packages/graylog-3.0-repository_latest.deb
sudo dpkg -i graylog-3.0-repository_latest.deb
sudo apt-get update

# Install Graylog
sudo apt-get install -y graylog-server

# Configure Graylog
sudo mv /tmp/server.conf /etc/graylog/server/server.conf
sudo chown root:root /etc/graylog/server/server.conf
sudo chmod 644 /etc/graylog/server/server.conf

# Enable the Graylog service
sudo systemctl daemon-reload
sudo systemctl enable graylog-server.service
sudo systemctl start graylog-server.service