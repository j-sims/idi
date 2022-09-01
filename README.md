# Isilon Data Insights (container build)

## Overview

This repo provides an easy to install dockerized build of the Isilon Data Insights Dashboards with Grafana, InfluxDB and the API stats collector. The docker build pulls from public repositories to installed and configure the containers enabling an easy to use graphical performance charting tool for monitoring and reporting on Isilon/PowerScale performance. The collector can scale to monitor as many clusters as needed.

## Table of Contents
- [Pre-Requisites](https://github.com/j-sims/idi#pre-requisites)
- [Quick Start Instructions](https://github.com/j-sims/idi#quick-start-instructions)
- [Linux Install Steps](https://github.com/j-sims/idi#steps-for-building-vms-for-docker)
  - [Rocky Linux](https://github.com/j-sims/idi#detailed-instructions-for-rocky-linux)
  - [Ubuntu Linux](https://github.com/j-sims/idi#detailed-instructions-for-ubuntu-linux)
- [Administration Info](https://github.com/j-sims/idi#administration-info)
  - [Upgrade](https://github.com/j-sims/idi#upgrading-idi)
  - [Backups](https://github.com/j-sims/idi#backing-up-the-database)
  - [Adding More Clusters](https://github.com/j-sims/idi#adding-more-clusters)

---
## Pre-Requisites
- Linux host (physical or VM) 
  - [Rocky Linux Detailed Build Steps](https://github.com/j-sims/idi#detailed-instructions-for-rocky-linux)
  - [Ubuntu Linux Detailed Build Steps](https://github.com/j-sims/idi#detailed-instructions-for-ubuntu-linux)
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
##### Step 4 - Use web browser to connect to the host on port 3000

---
## Steps for Building VMs for Docker
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
```

---
## Detailed Instructions for Ubuntu Linux
These steps provide details how building and Ubuntu Linux 22.04 VM and the docker environment needed to run idi

##### Download the ISO
https://releases.ubuntu.com/22.04/ubuntu-22.04-live-server-amd64.iso

##### Create a VM with a minimum of 4G Ram and 20G Disk 

##### Boot the VM
- Minimial Install of Ubuntu Server 22.04
- accept or change partitioning as desired
- Create default user
- Install Openssh for remote access
- Do not select more packages at install
- Start install and allow to run to completion then reboot


##### Update and Reboot
```
sudo su -
apt update
apt upgrade -y
reboot
```
##### Install docker, docker-compose & git
```
sudo su -
apt install -y docker.io docker-compose git
docker run hello-world  && echo Success
```

##### Open Firewall Port 3000
```
ufw allow 3000/tcp
```

##### Clone, Build and Start idi
```
git clone https://github.com/j-sims/idi.git
cd idi/
bash run.sh build
```
---
# Administration Info
Below is info on the build to ease the administration of the Isilon Data Insights environment

## Upgrading Idi
The updgrade process will shutdown idi temporarily, but all data should be retained and the process will restart idi when complete.
```
bash run.sh upgrade
```

## Known Issues
None