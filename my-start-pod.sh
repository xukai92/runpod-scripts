#!/usr/bin/env bash

# prepare directory for installation scripts
mkdir -p $HOME/tmp
cd $HOME/tmp

# link /workspace/.config to $HOME
if [ ! -d /workspace/.config ]; then
    mkdir -p /workspace/.config
fi
ln -s /workspace/.config $HOME/.config

# link /workspace/.cursor-server to $HOME
if [ ! -d $HOME/.cursor-server ]; then
    mkdir -p $HOME/.cursor-server
fi
ln -s /workspace/.cursor-server $HOME/.cursor-server

# install Homebrew
curl -L https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh > install-brew.sh
NONINTERACTIVE=1 bash install-brew.sh
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# install fish
HOMEBREW_NO_INSTALL_CLEANUP=1 brew install fish
echo "eval \"\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)\"" >> $HOME/.config/fish/config.fish

# set fish as default shell
chsh -s /home/linuxbrew/.linuxbrew/bin/fish

# install fisher
curl -L https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish > fisher.fish
fish -c "source fisher.fish; fisher install jorgebucaran/fisher; fisher install jhillyerd/plugin-git"

# install Mamba
curl -LO https://github.com/conda-forge/miniforge/releases/download/24.9.2-0/Miniforge3-Linux-x86_64.sh
bash Miniforge3-Linux-x86_64.sh -b -p /workspace/.conda -b -u
ln -s /workspace/.conda $HOME/.conda
$HOME/.conda/bin/mamba init fish

# create SSH key
if [ -d /workspace/.ssh ] && [ -f /workspace/.ssh/id_ed25519 ] && [ -f /workspace/.ssh/id_ed25519.pub ]; then
    cp /workspace/.ssh/id_ed25519* $HOME/.ssh/
else
    ssh-keygen -t ed25519 -C "pod@runpod" -f $HOME/.ssh/id_ed25519 -N ""
    mkdir -p /workspace/.ssh && cp $HOME/.ssh/id_ed25519* /workspace/.ssh/
fi
cat $HOME/.ssh/id_ed25519.pub