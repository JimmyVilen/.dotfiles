#!/bin/bash
# Installera Oh My Zsh (icke-interaktivt)
# run_once_ = körs bara en gång per maskin

set -e

if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh already installed, skipping."
    exit 0
fi

RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
