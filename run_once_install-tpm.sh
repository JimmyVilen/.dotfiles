#!/bin/bash
# Installera TPM (Tmux Plugin Manager)
# run_once_ = körs bara en gång per maskin

set -e

TPM_DIR="$HOME/.config/tmux/plugins/tpm"

if [ -d "$TPM_DIR" ]; then
    echo "TPM already installed, skipping."
    exit 0
fi

mkdir -p "$HOME/.config/tmux/plugins"
git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
