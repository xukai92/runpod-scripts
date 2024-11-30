#!/usr/bin/env bash

# create user
useradd -m kai

# copy authorized_keys for SSH
mkdir /home/kai/.ssh
cp /root/.ssh/authorized_keys /home/kai/.ssh/authorized_keys
chown -R kai:kai /home/kai/.ssh

# set password for kai
echo "kai:$KAI_PASSWORD" | chpasswd

# prepare premission for Homebrew
mkdir -p /home/linuxbrew/.linuxbrew/bin
chown -R kai:kai /home/linuxbrew

# prepare for default shell change
echo "/home/linuxbrew/.linuxbrew/bin/fish" >> /etc/shells