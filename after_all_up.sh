#!/bin/bash

(sleep 42424242& {
  # Update was done during provisioning this upgrades and installs pip
  sudo apt upgrade -y
  sudo apt-get install python3-pip -y

  # Copys all public keys into ~/.ssh and puts them as authorized_keys
  sudo cp /vagrant/keys/ubuntu1_id_rsa.pub /home/vagrant/.ssh/
  sudo cp /vagrant/keys/ubuntu2_id_rsa.pub /home/vagrant/.ssh/
  sudo cp /vagrant/keys/ubuntu3_id_rsa.pub /home/vagrant/.ssh/
  sudo cat /home/vagrant/.ssh/ubuntu1_id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
  sudo cat /home/vagrant/.ssh/ubuntu2_id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
  sudo cat /home/vagrant/.ssh/ubuntu3_id_rsa.pub >> /home/vagrant/.ssh/authorized_keys

  # Installs Ansible and Copies Files from Git
  if [ "$(hostname)" = "ubuntu3" ]; then
    sleep 30
    sudo apt install ansible -y 2>> ansible-install-log.txt
    git clone https://github.com/KDScheuer/Home-Lab-Files.git 2>> git-clone-log.txt
    sleep 10
    ansible-playbook /home/vagrant/Home-Lab-Files/Ansible_Files/inital_env_setup.yml -i /home/vagrant/Home-Lab-Files/Ansible_Files/inventory 2>> env-setup-results.txt
  fi
}) &
