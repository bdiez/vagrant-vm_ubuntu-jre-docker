#!/bin/bash

ensure_netplan_apply() {
    sleep 5   
    sudo netplan apply
}

step=1
step() {
    echo "Step $step $1"
    step=$((step+1))
}
update_ubuntu(){
    step "=========================== Update system"
    sudo apt update
    sudo apt upgrade -y
}

resolve_dns() {
    step "===== Create symlink to /run/systemd/resolve/resolv.conf ====="
    sudo rm /etc/resolv.conf
    sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
}

install_docker() {
    step "===== Installing docker ====="
    sudo apt install -y docker.io
    sudo groupadd docker
    sudo gpasswd -a $USER docker
    # Add vagrant to docker group
    sudo groupadd docker
    sudo gpasswd -a vagrant docker
    # Setup docker daemon host
    # Read more about docker daemon https://docs.docker.com/engine/reference/commandline/dockerd/
    sed -i 's/ExecStart=.*/ExecStart=\/usr\/bin\/dockerd -H unix:\/\/\/var\/run\/docker.sock -H tcp:\/\/192.168.121.210/g' /lib/systemd/system/docker.service
    sudo systemctl daemon-reload
    sudo systemctl restart docker
}

install_java(){
    step "===== Remove default Java ====="
    sudo apt purge java-common -y
    step "===== Installing Java ====="
    mv /tmp/jre-8u202-linux-x64.tar.gz /opt/
    cd /opt/ 
    tar xvf jre-8u202-linux-x64.tar.gz
    cd /opt/jre1.8.0_202/
    rm /opt/jre-8u202-linux-x64.tar.gz
}

main() {
    update_ubuntu
    install_docker
    install_java
}

main