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
      sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
      sudo systemctl restart sshd
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
      sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
      sudo systemctl restart sshd
    SHELL
  end
end
