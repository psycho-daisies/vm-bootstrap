#!/usr/bin/env bash
# simple_mint_install.sh
# Installs APT + Flatpak apps on Linux Mint using inline arrays.

set -euo pipefail

# ---------- Packages ----------
APT_APPS=(
  git
  curl
  wget
  vim
  htop
  gnome-tweaks
  flatpak
)

FLATPAK_APPS=(
  org.mozilla.firefox
  com.visualstudio.code
  com.spotify.Client
  com.discordapp.Discord
)

# ---------- Functions ----------
have() { command -v "$1" >/dev/null 2>&1; }

# ---------- APT ----------
echo "🔄 Updating APT package index..."
sudo apt update -y

echo "📦 Installing APT apps: ${APT_APPS[*]}"
sudo DEBIAN_FRONTEND=noninteractive apt install -y "${APT_APPS[@]}"

# ---------- Flatpak ----------
if ! have flatpak; then
  echo "📦 Installing Flatpak via APT..."
  sudo apt install -y flatpak
fi

# Ensure Flathub remote exists
if ! flatpak remotes | awk '{print $1}' | grep -qx flathub; then
  echo "➕ Adding Flathub remote..."
  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# Install Flatpak apps
for app in "${FLATPAK_APPS[@]}"; do
  if flatpak list --app | awk '{print $1}' | grep -qx "$app"; then
    echo "✔️  Already installed: $app"
  else
    echo "⬇️  Installing Flatpak app: $app"
    flatpak install -y flathub "$app"
  fi
done

echo "✅ Done! All APT + Flatpak apps installed."
