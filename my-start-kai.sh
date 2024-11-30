# install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" --force

# post Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# install fish
brew install fish

# set fish as default shell
chsh -s /home/linuxbrew/.linuxbrew/bin/fish

# install Mamba
curl -LO https://github.com/conda-forge/miniforge/releases/download/24.9.2-0/Miniforge3-Linux-x86_64.sh
bash Miniforge3-Linux-x86_64.sh -b -p /home/kai/.conda -f
/home/kai/.conda/bin/mamba init fish

# create SSH key
ssh-keygen -t ed25519 -C "kai@runpod" -f /home/kai/.ssh/id_ed25519 -N ""
cat /home/kai/.ssh/id_ed25519.pub