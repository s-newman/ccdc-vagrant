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
sudo apt-get install -y \
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
echo "deb https://artifacts.elastic.co/packages/oss-6.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-6.x.list
sudo apt-get update

# Install Elasticsearch
sudo apt-get install -y elasticsearch-oss

# Configure Elasticsearch
cat << EOF > elasticsearch.yml
cluster.name: graylog
path.data: /var/lib/elasticsearch
path.logs: /var/log/elasticsearch
action.auto_create_index: false
EOF
sudo mv elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
sudo chown root:elasticsearch /etc/elasticsearch/elasticsearch.yml
sudo chmod 660 /etc/elasticsearch/elasticsearch.yml

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
cat << EOF > server.conf
is_master = true
node_id_file = /etc/graylog/server/node-id
password_secret = pnHkqaGI4pgKmPR3lGNK6E2Euqkr8sB0EiSlP4iH7PE=
root_password_sha2 = 2818401c83a40cdb0cb31e91856423ed260de905f3a5965f80c3fba9be5c120f
bin_dir = /usr/share/graylog-server/bin
data_dir = /var/lib/graylog-server
plugin_dir = /usr/share/graylog-server/plugin
http_bind_address = 192.168.33.102:9000
http_publish_uri = http://192.168.33.102:9000/
rotation_strategy = count
elasticsearch_max_docs_per_index = 20000000
elasticsearch_max_number_of_indices = 20
retention_strategy = delete
elasticsearch_shards = 4
elasticsearch_replicas = 0
elasticsearch_index_prefix = graylog
allow_leading_wildcard_searches = false
allow_highlighting = false
elasticsearch_analyzer = standard
output_batch_size = 500
output_flush_interval = 1
output_fault_count_threshold = 5
output_fault_penalty_seconds = 30
processbuffer_processors = 5
outputbuffer_processors = 3
processor_wait_strategy = blocking
ring_size = 65536
inputbuffer_ring_size = 65536
inputbuffer_processors = 2
inputbuffer_wait_strategy = blocking
message_journal_enabled = true
message_journal_dir = /var/lib/graylog-server/journal
lb_recognition_period_seconds = 3
mongodb_uri = mongodb://localhost/graylog
mongodb_max_connections = 1000
mongodb_threads_allowed_to_block_multiplier = 5
proxied_requests_thread_pool_size = 32
EOF
sudo mv server.conf /etc/graylog/server/server.conf
sudo chown root:elasticsearch /etc/graylog/server/server.conf
sudo chmod 644 /etc/graylog/server/server.conf

# Enable the Graylog service
sudo systemctl daemon-reload
sudo systemctl enable graylog-server.service
sudo systemctl start graylog-server.service