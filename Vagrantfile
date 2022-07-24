Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/focal64"
    config.vm.provision:shell, inline: <<-SHELL
        echo "root:root" | sudo chpasswd
    
    SHELL
        config.vm.define "ubuntu" do |ubuntu|
        ubuntu.vm.hostname = "ubuntu"
        
    end

    config.vm.provision:"file", source: "jre-8u202-linux-x64.tar.gz", destination: "/tmp/" 
    config.vm.provision:shell, path: "init.sh"
    config.vm.provision:shell, inline: <<-SHELL
        echo "export JAVA_HOME=/opt/jre1.8.0_202" >> /home/vagrant/.bashrc
        echo "export PATH=$PATH:/opt/jre1.8.0_202/bin" >> /home/vagrant/.bashrc
        source .bashrc
    SHELL
      

end