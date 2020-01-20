Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.provision "shell", path: "common.sh"
  ## Master
  config.vm.define "k8s-master" do | master |
      master.vm.network "private_network", ip: "192.168.50.10"
      master.vm.hostname = "master.private.com"
      master.vm.provider "virtualbox" do | vb |
           vb.name = "k8s-master"
           vb.cpus = 2
           vb.memory = 2042
      end
      master.vm.provision "shell", path: "master_setup.sh"
   end
## Client-1
  config.vm.define "worker-1" do | worker |
      worker.vm.network "private_network", ip: "192.168.50.11"
      worker.vm.hostname = "worker-1.private.com"
      worker.vm.provider "virtualbox" do | vb |
           vb.name = "k8s-worker-1"
           vb.cpus = 1
           vb.memory = 1024
      end
      worker.vm.provision "shell", path: "worker_setup.sh"
   end

## Client-2
  config.vm.define "worker-2" do | worker |
      worker.vm.network "private_network", ip: "192.168.50.12"
      worker.vm.hostname = "worker-2.private.com"
      worker.vm.provider "virtualbox" do | vb |
           vb.name = "k8s-worker-2"
           vb.cpus = 1
           vb.memory = 1024
      end
      worker.vm.provision "shell", path: "worker_setup.sh"
   end
end 
