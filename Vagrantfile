VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "centos65-x86_64-20131205"
  config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v6.5.1/centos65-x86_64-20131205.box"

  # Set the IP address of unused if it would conflict with the IP you are using already
  config.vm.network :private_network, ip: "192.168.33.6"

  # Set the VirtualBox Configration
  config.vm.provider "virtualbox" do |vb|
    # Change memory size
    vb.customize ["modifyvm", :id, "--memory", 1024]
  end

  # Synced Folder
  config.vm.synced_folder "src", "/var/www/laravel-selenium.loc", :mount_options => ["dmode=777", "fmode=777"]
  config.vm.synced_folder "src", "/var/www/testing.laravel-selenium.loc", :mount_options => ["dmode=777", "fmode=777"]

  # Install chef
  config.vm.provision :shell, :inline => "curl -L 'https://www.getchef.com/chef/install.sh' | sudo bash"

  # provisioning with chef solo.
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["./provision/chef/cookbooks","./provision/chef/site-cookbooks"]
    chef.data_bags_path = ["./provision/chef/data_bags"]
    chef.add_recipe "chkconfig"
    chef.add_recipe "selinux"
    chef.add_recipe "yum"
    chef.add_recipe "ntp"
    chef.add_recipe "nkf"
    chef.add_recipe "remi"
    chef.add_recipe "rpmforge"
    chef.add_recipe "epel"
    chef.add_recipe "nodejs"
    chef.add_recipe "npm"
    chef.add_recipe "httpd"
    chef.add_recipe "php"
    chef.add_recipe "selenium-server"
    chef.add_recipe "xvfb"
    chef.add_recipe "firefox"
  end

  # Do provision.sh
  config.vm.provision "shell", path: "provision/provision.sh"

end
