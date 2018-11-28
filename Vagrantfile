# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'json'

cwd = File.expand_path("..", __FILE__)

digocean = nil
File::open(File.join(cwd, "auth", "digitalocean.json"), "r") do |f|
    digocean = JSON.load(f)
end

LOCAL_DEV_PRIVATE_IP = "192.168.33.10"

#text for a command to be invoked by the virtual server to find out its ip
if digocean['ENABLE_DIGITALOCEAN'] == true
    OUTPUT_IP = "dig +short myip.opendns.com @resolver1.opendns.com"
  else
    OUTPUT_IP = "echo #{LOCAL_DEV_PRIVATE_IP}"
  end


Vagrant.configure("2") do |config|
  if digocean['ENABLE_DIGITALOCEAN'] == true
    config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ['.vagrant',
                                                                             '.git',
                                                                             File.join('proj',
                                                                                       'myproject',
                                                                                       'settings',
                                                                                       'allowed_hosts.py')
                                                                             ]
    config.ssh.username = 'vagrant' # default for digitalocean is root
    config.vm.provider :digital_ocean do |provider, override|
      override.vm.box = digocean['override.vm.box']
      override.vm.box_url = digocean['override.vm.box_url']
      override.ssh.private_key_path = File.join(cwd, *digocean['override.ssh.private_key_path'])
      provider.token = digocean['provider.token']
      provider.image = digocean['provider.image']
      provider.region = digocean['provider.region']
    end
  else
    config.vm.box = "ubuntu/xenial64"
    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    config.vm.network "private_network", ip: LOCAL_DEV_PRIVATE_IP
  end

  config.vm.provision :shell, path: File.join(cwd,
                                              "setup_provision",
                                              "raise_firewall.sh")
  config.vm.provision :shell, path: File.join(cwd,
                                              "setup_provision",
                                              "install_host_machine_dependencies.sh")
  config.vm.provision :shell, path: File.join(cwd,
                                              "setup_provision",
                                              "create_venv_apply_requirements.sh")
  config.vm.provision :shell, inline: "python3 " + File.join("/vagrant",
                                                             "setup_provision",
                                                             "db_init",
                                                             "main.py")
  config.vm.provision :shell, path: File.join(cwd,
                                              "setup_provision",
                                              "django_setup.sh")

  config.vm.provision :shell, inline: OUTPUT_IP + " | " + File.join("/vagrant",
                                                                   "setup_provision",
                                                                   "django_setup.sh")

  config.vm.provision :shell, inline: OUTPUT_IP + " | " + File.join("/vagrant",
                                                                    "setup_provision",
                                                                    "gunicorn_and_nginx_site_setup.sh")

  config.vm.provision :shell, run: "always", inline: "systemctl restart gunicorn"
end
