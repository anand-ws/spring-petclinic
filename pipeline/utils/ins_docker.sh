#!/bin/bash

function install_docker ()
{
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

echo "adding key"
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC7og7svH67R33uwVwOg4165KNfzVFCDP96zpzXE7x94Q8a+KJq7KehElZQdOLcLyXt0R4QBjj9OUZRLeocWG0V4Saht7WtzWHZn+kuZxyTF2rzN4s6CGkOCHD+Kzjm7VhoWQX/GDbDQAYDIL+v8LDfYILCu+M+xBH+BcWQwDY78sGMhKei3SbjDwhKWGc5DlMUuY7fi1tjFeLihwKhrMJRHdXst3JPQRmHqU8VWSzEZCccXWRWrYeqPygFgldfzzqKGp17vBQ+gzMvvqkb/qxSgef694iVP44LXBHBbhYinHS91XHn+9qYk/nV3+0OXd3ukNAD7hiPwAYmj2n8H/SsR0WpAVPP7CYqSRwgtSp/3vX8+NeCY8Nw8mqqO6xy+adTj0pHf0+wjgl5qUPiy0nbQPXrAqGuiocQ+KAgKLtVakSvGrY6vPo9FIUAGJYjgwyGDhpJGZ62xG0TyC4Hy6rb1Lr6hyGUdbEp+b2TRpKqhYu8eYpi8Zqwmp2SrCND0HymMirYVO2wADYCOxC18JVqLikVTkZhXqnYH6qMIv3W2X0tMaDI7U+RNwxipZ9u8wBQUb1EDs4q4/qUWyMhztcOZO3CyOKP/j/mj0f0kOm2vxtnqQOj3GYOFlRyKuka3s1u/rWG0q/e7r72ORjkler8EjfcOOvj5d7NPpJ00HXMEw== apps" >> /home/ubuntu/.ssh/authorized_keys

install_docker
apt install python3-pip -y
pip3 install docker
