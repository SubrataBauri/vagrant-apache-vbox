
Vagrant.configure(2) do |config|

#unless Vagrant.has_plugin?("vagrant-vbguest")
#  raise 'vagrant-vbguest plugin is not installed!  Please run the following command: vagrant plugin install vagrant-vbguest'
#end

  required_plugins = %w( vagrant-vbguest vagrant-disksize )
  _retry = false
  required_plugins.each do |plugin|
      unless Vagrant.has_plugin? plugin
          system "vagrant plugin install #{plugin}"
          _retry=true
      end
  end

  # Specify the base box
  config.vm.box = "ubuntu/trusty64"
  config.disksize.size = "20GB"

  # Setup port forwarding
  #config.vm.network "forwarded_port", guest: 22, host: 1022, host_ip: "127.0.0.1", id: 'ssh'

  # Setup network
  config.vm.network "private_network", ip: "10.0.0.100"
  config.vm.hostname = "dev.domainname.com"

  # Setup synced folder
    config.vm.synced_folder "projects/", "/var/www/html", group: "www-data", owner: "vagrant", :mount_options => ['dmode=775', 'fmode=775']

  # CUSTOMIZATION
   config.vm.provider "virtualbox" do |vb|

     vb.name = "vagrant-apache-vbox"
  
     # Memory on the VM (You can change this and do 'vagrant up' to apply the memory changes) : 
     vb.memory = "2048"
     vb.cpus = 4
   end

  # PROVISION
   # Shell provisioning
    config.vm.provision "shell" do |s|
      s.path = "vagrant/bootstrap.sh"
    end

end
