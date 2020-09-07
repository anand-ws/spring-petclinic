#!/bin/bash

function install_docker () {
  # installing docker utils and unzip
  sudo apt-get install \
          ca-certificates \
          curl gnupg-agent \
          apt-transport-https \
          software-properties-common unzip -y 

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo apt-key fingerprint 0EBFCD88
  sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io -y

  # testing docker
  docker run hello-world
  rm -rf /var/cache/apt/

}


function install_jenkins_docker () {

  docker network create jenkins
  docker volume create jenkins-docker-certs

  docker container run \
    --name jenkins-docker \
    --restart always \
    --detach \
    --privileged \
    --network jenkins \
    --network-alias docker \
    --env DOCKER_TLS_CERTDIR=/certs \
    --volume jenkins-docker-certs:/certs/client \
    --volume /mnt/data/jenkins:/var/jenkins_home \
    --publish 2376:2376 \
    docker:dind

  docker container run \
    --name jenkins-blueocean \
    --restart always \
    --detach \
    --network jenkins \
    --env DOCKER_HOST=tcp://docker:2376 \
    --env DOCKER_CERT_PATH=/certs/client \
    --env DOCKER_TLS_VERIFY=1 \
    --publish 80:8080 \
    --publish 50000:50000 \
    --volume /mnt/data/jenkins:/var/jenkins_home \
    --volume jenkins-docker-certs:/certs/client:ro \
    jenkinsci/blueocean
}


function mount_disk {

  ######### mounting secondary disk #########
  disk_size=5
  disk_loc=$(lsblk | grep ${disk_size}G | awk '{print $1}')
  echo $disk_loc

  disk_details=$(file -s /dev/$disk_loc | cut -d ' ' -f 2)
  echo $disk_details 

  if [[ $disk_details == "data" ]]; then
    mkfs.ext4 -m 0 -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/$disk_loc -F
  fi

  echo "/dev/$disk_loc    /mnt/data/  ext4  defaults    0 0" | sudo tee -a /etc/fstab # adding for mount
  mkdir /mnt/data/
  mount -a
  mkdir /mnt/data/jenkins/
  chown 1000:1000 /mnt/data/jenkins/

}

function install_ansible () {

  apt install python3-pip -y
  pip3 install docker
  pip3 install ansible
}

# updating and upgrading packages
sudo apt-get update && sudo apt-get upgrade -y
sudo apt  install awscli -y 

install_docker
mount_disk
install_jenkins_docker
install_ansible

sleep 30
mkdir ~/.aws/
echo """[default]
region = ap-south-1
output = json
""" > ~/.aws/config

initialAdminPassword=$(cat /mnt/data/jenkins/secrets/initialAdminPassword)
sns_arn="arn:aws:sns:ap-south-1:544350377237:installation_update"
aws sns publish --topic-arn $sns_arn --message "initialAdminPassword : $initialAdminPassword"


echo "*****************************************************"
echo "**************** INSTALL ****************************"
echo "************************ DONE ***********************"
echo "*****************************************************"
