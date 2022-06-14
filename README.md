# Isilon Data Insights (container build)

## Overview

This repo provides an easy to install dockerized build of the Isilon Data Insights Dashboards with Grafana, InfluxDB and the API stats collector. The docker build pulls from public repositories to installed and configure the containers enabling an easy to use graphical performance charting tool for monitoring and reporting on Isilon/PowerScale performance. The collector can scale to monitor as many clusters as needed.

## Pre-Requisites
- Linux host (physical or VM) 
  - [Rocky Linux Detailed Build Steps](https://github.com/j-sims/idi/edit/main/README.md#detailed-instructions-for-rocky-linux)
  - [Ubuntu Linux Detailed Build Steps](https://github.com/j-sims/idi/edit/main/README.md#detailed-instructions-for-ubuntu-linux)
- 1 CPU and 4G of memory (more if monitoring more clusters)
- recent version of docker (tested with 1:20), docker-compose and git
- open firewall port 3000 for grafana access


## Quick Start Instructions
Run all steps as the root user or docker enabled user.

##### Step 1 - Clone the repository
```
git clone https://github.com/j-sims/idi.git
```
##### Step 2 - Change to the idi directory
```
cd idi
```
##### Step 3 - Build the containers
```
bash run.sh build
```
##### Step 4 - Start the containers
```
bash run.sh start
```
##### Step 5 - Use web browser to connect to the host on port 3000

<p>
  </p>
Below are the detailed steps for building a VM to run the docker environment on.

---
## Detailed Instructions for Rocky Linux
These steps provide details how building and Rocky Linux 8.6 (CentOS) VM and the docker environment needed to run idi

##### Download the ISO
https://rockylinux.org/download

##### Create a VM with a minimum of 4G Ram and 20G Disk 

##### Boot the VM
- default install
- set root password
- accept or change partitioning as desired
- Initiate install

##### Update and Reboot
```
dnf update -y
reboot
```
##### Install docker & git ([credit](https://www.linuxtechi.com/install-docker-and-docker-compose-rocky-linux/))
```
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce git
systemctl start docker
systemctl enable docker
docker run hello-world  && echo Success
```

##### Install docker-compose
```
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version  && echo Success
```

##### Open Firewall Port 3000
```
firewall-cmd --zone=public --permanent --add-port 3000/tcp
```

##### Clone, Build and Start idi
```
git clone https://github.com/j-sims/idi.git
cd idi/
bash run.sh build
bash run.sh start
```

---
## Detailed Instructions for Ubuntu Linux

