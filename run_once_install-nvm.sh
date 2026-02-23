#!/bin/bash
# Installera nvm (Node Version Manager)
# run_once_ = körs bara en gång per maskin

set -e

if [ -d "$HOME/.nvm" ]; then
    echo "nvm already installed, skipping."
    exit 0
fi

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh | bash
