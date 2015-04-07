# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  #config.vm.box = "vEOS_4.14.4F"

  config.vm.provider 'virtualbox' do |_, override|
    # Disable synced folders
    config.vm.synced_folder ".", "/vagrant", disabled: true
  end

  # Configure the default ssh username for EOS
  config.ssh.username = "root"

  # Enable eAPI in the EOS config
  config.vm.provision "shell", inline: <<-SHELL
    FastCli -p 15 -c "configure
    management api http-commands
      no shutdown
    end
    copy running-config startup-config"
  SHELL

  # Enable eAPI over HTTP in the EOS config
  #  FastCli -p 15 -c "configure
  #  management api http-commands
  #    no protocol https
  #    protocol http
  #    no shutdown
  #  end
  #  copy running-config startup-config"
  #SHELL
end