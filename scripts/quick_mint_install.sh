#!/usr/bin/env bash
# quick_mint_install.sh

# Update & install APT apps
sudo apt update -y
sudo apt install -y git curl wget vim htop gnome-tweaks flatpak

# Add Flathub remote (if not already added)
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Flatpak apps
flatpak install -y flathub org.mozilla.firefox com.visualstudio.code com.discordapp.Discord
