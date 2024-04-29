#!/bin/bash

(sleep 60 & {
  # Update was done during provisioning this upgrades and installs pip
  sudo apt upgrade -y
  sudo apt-get install python3-pip -y

  # Sleeping to Allow Time for Other Boxes to Become Up and Place Pub Key in Shared Folder
  if [ "$(hostname)" = "ubuntu1" ]; then
    sleep 420
  elif [ "$(hostname)" = "ubuntu2" ]; then
    sleep 360
  elif [ "$(hostname)" = "ubuntu3" ]; then
    sleep 30
    sudo apt install ansible -y
    git clone https://github.com/KDScheuer/Home-Lab-Files.git
  fi

  # Copys all public keys into ~/.ssh and puts them as authorized_keys
  sudo cp /vagrant/keys/ubuntu1_id_rsa.pub /home/vagrant/.ssh/
  sudo cp /vagrant/keys/ubuntu2_id_rsa.pub /home/vagrant/.ssh/
  sudo cp /vagrant/keys/ubuntu3_id_rsa.pub /home/vagrant/.ssh/
  sudo cat /home/vagrant/.ssh/ubuntu1_id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
  sudo cat /home/vagrant/.ssh/ubuntu2_id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
  sudo cat /home/vagrant/.ssh/ubuntu3_id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
}) &
