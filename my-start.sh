#!/usr/bin/env bash

# create user
useradd -m pod

# copy authorized_keys for SSH
mkdir /home/pod/.ssh
cp /root/.ssh/authorized_keys /home/pod/.ssh/authorized_keys
chown -R pod:pod /home/pod/.ssh

# set password for pod
echo "pod:$POD_PASSWORD" | chpasswd

# prepare premission for Homebrew
mkdir -p /home/linuxbrew/.linuxbrew/bin
chown -R pod:pod /home/linuxbrew

# prepare for default shell change
echo "/home/linuxbrew/.linuxbrew/bin/fish" >> /etc/shells