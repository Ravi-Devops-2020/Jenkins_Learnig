#! /bin/bash

# V1.1 

# Remove existing docker engine 
sudo yum remove docker-ce

#Remove all docker images/volumes
sudo rm -rf /var/lib/docker

echo " Existing docker setup removed successfully ============================================> "

# Remove all existing packages of Docker
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
				  
# Install required packages. yum-utils provides the yum-config-manager utility, and device-mapper-persistent-data and lvm2 are required by the devicemapper storage driver.
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

# Use the following command to set up the stable repository.
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# Install the latest version of Docker Engine - Community and containerd
sudo yum install docker-ce docker-ce-cli containerd.io

# start docker service and then enable to docker service to start when server is started
sudo systemctl start docker
sudo systemctl enable docker

echo " Show status of docker ============================================> "
sudo systemctl status docker

# add user to docker service
sudo usermod -aG docker vagrant

sudo rm /usr/local/bin/docker-compose
sudo pip uninstall docker-compose
echo " Existing docker-compose removed successfully ============================================> "
echo "===============> Start installing docker-compose"
# Install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Apply executable permissions to the binary
sudo chmod +x /usr/local/bin/docker-compose

# Check after install of docker-compose

docker-compose --version



 
