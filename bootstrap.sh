#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${HOME}/vm-bootstrap"
PROFILE="${1:-default}"

if [[ ! -d "$REPO_DIR" ]]; then
  echo "Cloning repo to $REPO_DIR..."
  git clone https://github.com/yourname/vm-bootstrap.git "$REPO_DIR"
fi

cd "$REPO_DIR/scripts"

if command -v apt >/dev/null 2>&1; then
  ./install_apt.sh "$PROFILE"
elif command -v dnf >/dev/null 2>&1; then
  ./install_fedora.sh "$PROFILE"
elif command -v pacman >/dev/null 2>&1; then
  ./install_arch.sh "$PROFILE"
else
  echo "Unsupported distro (need apt/dnf/pacman)."
  exit 1
fi
