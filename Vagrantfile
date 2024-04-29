Vagrant.configure("2") do |config|
  config.vm.define "ubuntu1" do |ubuntu1|
    ubuntu1.vm.box = "ubuntu/focal64"
    ubuntu1.vm.hostname = "ubuntu1"
    ubuntu1.vm.network "private_network", ip: "192.168.100.2", auto_config: false
    ubuntu1.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh"
    ubuntu1.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 1
    end

    ubuntu1.vm.provision "shell", inline: <<-SHELL
      sudo ip link set enp0s8 up
      sudo ip addr add 192.168.100.2/24 dev enp0s8

      sudo apt-get update -y
      sudo apt-get install -y openssh-server

      sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
      sudo sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
      sudo systemctl restart sshd
      ssh-keygen -t rsa -N "" -f /home/vagrant/.ssh/id_rsa
      sudo cp /home/vagrant/.ssh/id_rsa.pub /vagrant/keys/ubuntu1_id_rsa.pub
    
      sudo chown vagrant:vagrant /home/vagrant/.ssh/id_rsa
      sudo chown vagrant:vagrant /home/vagrant/.ssh/id_rsa.pub
    SHELL
  end

  config.vm.define "ubuntu2" do |ubuntu2|
    ubuntu2.vm.box = "ubuntu/focal64"
    ubuntu2.vm.hostname = "ubuntu2"
    ubuntu2.vm.network "private_network", ip: "192.168.100.3", auto_config: false
    ubuntu2.vm.network "forwarded_port", guest: 22, host: 2223, id: "ssh"
    ubuntu2.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 1
    end

    ubuntu2.vm.provision "shell", inline: <<-SHELL
      sudo ip link set enp0s8 up
      sudo ip addr add 192.168.100.3/24 dev enp0s8
      
      sudo apt-get update -y
      sudo apt-get install -y openssh-server

      sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
      sudo sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
      sudo systemctl restart sshd
      ssh-keygen -t rsa -N "" -f /home/vagrant/.ssh/id_rsa
      sudo cp /home/vagrant/.ssh/id_rsa.pub /vagrant/keys/ubuntu2_id_rsa.pub
    
      sudo chown vagrant:vagrant /home/vagrant/.ssh/id_rsa
      sudo chown vagrant:vagrant /home/vagrant/.ssh/id_rsa.pub
    
    SHELL
  end

  config.vm.define "ubuntu3" do |ubuntu3|
    ubuntu3.vm.box = "ubuntu/focal64"
    ubuntu3.vm.hostname = "ubuntu3"
    ubuntu3.vm.network "private_network", ip: "192.168.100.4", auto_config: false
    ubuntu3.vm.network "forwarded_port", guest: 22, host: 2224, id: "ssh"
    ubuntu3.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 1
    end

    ubuntu3.vm.provision "shell", inline: <<-SHELL
      sudo ip link set enp0s8 up
      sudo ip addr add 192.168.100.4/24 dev enp0s8
      
      sudo apt-get update -y
      sudo apt-get install -y openssh-server

      sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
      sudo sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
      sudo systemctl restart sshd
      ssh-keygen -t rsa -N "" -f /home/vagrant/.ssh/id_rsa
      sudo cp /home/vagrant/.ssh/id_rsa.pub /vagrant/keys/ubuntu3_id_rsa.pub

      sudo chown vagrant:vagrant /home/vagrant/.ssh/id_rsa
      sudo chown vagrant:vagrant /home/vagrant/.ssh/id_rsa.pub

    SHELL
  end
  
  config.vm.provision "shell", path: "after_all_up.sh"
end

