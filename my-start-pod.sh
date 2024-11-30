#!/usr/bin/env bash

# prepare directory for installation scripts
mkdir -p $HOME/tmp
cd $HOME/tmp

# install Homebrew
curl -L https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh > install-brew.sh
NONINTERACTIVE=1 bash install-brew.sh
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# install fish
brew install fish

# set fish as default shell
chsh -s /home/linuxbrew/.linuxbrew/bin/fish

# install fisher
curl -L https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish > fisher.fish
source fisher.fish
fisher install jorgebucaran/fisher
fisher install jhillyerd/plugin-git

# install Mamba
curl -LO https://github.com/conda-forge/miniforge/releases/download/24.9.2-0/Miniforge3-Linux-x86_64.sh
bash Miniforge3-Linux-x86_64.sh -b -p $HOME/.conda -b
$HOME/.conda/bin/mamba init fish

# create SSH key
ssh-keygen -t ed25519 -C "pod@runpod" -f $HOME/.ssh/id_ed25519 -N ""
cat $HOME/.ssh/id_ed25519.pub