#!/bin/bash

(sleep 420 & {
  # Update was done during provisioning this upgrades and installs pip
  sudo apt upgrade -y
  sudo apt-get install python3-pip -y

  # Copys all public keys into ~/.ssh and puts them as authorized_keys
  retry_copy_and_append_ssh_keys() {
  local retries=5
  local success=false
  for i in {1..3}; do
    key="/vagrant/keys/ubuntu${i}_id_rsa.pub"
    while [ "$retries" -gt 0 ]; do
      if sudo cp "$key" /home/vagrant/.ssh/ && sudo cat "$key" >> /home/vagrant/.ssh/authorized_keys; then
        success=true
        break
      else
        echo "Failed to copy and append $key, retrying..."
        ((retries--))
        sleep 30  # Adjust the sleep time as needed
      fi
    done
    if [ "$success" = true ]; then
      echo "Successfully copied and appended $key"
    else
      echo "Failed to copy and append $key after multiple attempts, exiting..."
      exit 1
    fi
  done
}

# Call the function
retry_copy_and_append_ssh_keys

  # Installs Ansible and Copies Files from Git
  if [ "$(hostname)" = "ubuntu3" ]; then
    sleep 30
    sudo apt install ansible -y 2>> ansible-install-log.txt
    git clone https://github.com/KDScheuer/Home-Lab-Files.git 2>> git-clone-log.txt
    sleep 10
    ansible-playbook /home/vagrant/Home-Lab-Files/Ansible_Files/inital_env_setup.yml -i /home/vagrant/Home-Lab-Files/Ansible_Files/inventory >> env-setup-results.txt
  fi
}) &
