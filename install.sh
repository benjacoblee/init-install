#!/bin/bash

log_file="./${USER}-${HOSTNAME}-installation.log"
touch "$log_file"

lecho() {
    current_date=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$current_date: $USER: $*" >>"$log_file"
    echo "$*"
}

lecho "Updating & upgrading packages..."
sudo apt update -y && sudo apt upgrade -y

lecho "Installing git..."
if sudo apt install -y git; then
    lecho "Done."
else
    lecho "git installation failed."
fi

lecho "Installing fish..."
if sudo apt-add-repository ppa:fish-shell/release-3 -y && sudo apt update -y && sudo apt install fish; then
    lecho "Done."
else
    lecho "fish installation failed."
fi

if ! type "make" >/dev/null; then
    lecho "Installing make..."
    if sudo apt install make; then
        lecho "Done."
    else
        lecho "make installation failed".
    fi
fi

lecho "Installing cargo..."
if curl https://sh.rustup.rs -sSf | sudo -E bash -s; then
    lecho "Done"
else
    lecho "cargo installation failed."
fi

# install fisher, nvm.fish

lecho "Installing Tailscale..."
if sudo curl -fsSL https://tailscale.com/install.sh | sudo -E bash -s; then
    lecho "Done."
else
    lecho "Tailscale installation failed."
fi

lecho "Installing OpenSSH..."
if sudo apt install -y openssh-client && sudo apt install -y openssh-server; then
    lecho "Done."
else
    lecho "OpenSSH installation failed."
fi

lecho "Installing bat..."
wget https://github.com/sharkdp/bat/releases/download/v0.23.0/bat_0.23.0_amd64.deb
if sudo dpkg -i bat_0.23.0_amd64.deb; then
    sudo rm ./bat_0.23.0_amd64.deb
    lecho "Done."
else
    lecho "bat installation failed."
fi

# NOTE: doesn't work on ZorinOS
lecho "Installing exa..."
if sudo apt install -y exa; then
    lecho "Done."
else
    lecho "exa installation failed."
fi

lecho "Installing dust..."
sudo apt install -y curl lsb-release wget
if curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get &&
    sudo deb-get install du-dust; then
    lecho "Done".
else
    lecho "dust installation failed."
fi

lecho "Installing fd..."
if sudo apt install -y fd-find; then
    lecho "Done."
else
    lecho "fd installation failed."
fi

lecho "Installing zoxide..." # `add zoxide init fish | source` to ~/.config/fish/config.fish
if sudo apt install -y zoxide; then
    lecho "Done."
else 
    lecho "Zoxide installation failed."
fi
# Depends on npm
# lecho "Installing tldr..."
# if npm i -g tldr; then
#     lecho "Done."
# else
#     lecho "tldr installation failed."
# fi

lecho "Installing rg..."
wget https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
if sudo dpkg -i ripgrep_13.0.0_amd64.deb; then
    sudo rm ./ripgrep_13.0.0_amd64.deb
    lecho "Done."
else
    lecho "rg installation failed."
fi
