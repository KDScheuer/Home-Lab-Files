#!/bin/bash

(sleep 10 & {
  # Update was done during provisioning this upgrades and installs pip
  sudo apt upgrade -y
  sleep 60
  sudo apt-get install python3-pip -y
  sleep 60

  # Sleeping to Allow Time for Other Boxes to Become Up and Place Pub Key in Shared Folder
  if [ "$(hostname)" = "ubuntu1" ]; then
    sleep 180
  elif [ "$(hostname)" = "ubuntu2" ]; then
    sleep 120
  elif [ "$(hostname)" = "ubuntu3" ]; then
    git clone https://github.com/KDScheuer/Home-Lab-Files.git
    sleep 10
    sudo apt install ansible -y
    sleep 60
  fi

  # Copys all public keys into ~/.ssh and puts them as authorized_keys
  sudo cp /vagrant/keys/ubuntu1_id_rsa.pub /home/vagrant/.ssh/
  sudo cp /vagrant/keys/ubuntu2_id_rsa.pub /home/vagrant/.ssh/
  sudo cp /vagrant/keys/ubuntu3_id_rsa.pub /home/vagrant/.ssh/
  sudo cat /home/vagrant/.ssh/ubuntu1_id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
  sudo cat /home/vagrant/.ssh/ubuntu2_id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
  sudo cat /home/vagrant/.ssh/ubuntu3_id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
}) &
