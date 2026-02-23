#!/bin/bash
# Installera grundläggande apt-paket
# run_once_ = körs bara en gång per maskin

set -e

sudo apt-get update -qq

sudo apt-get install -y \
    zsh \
    tmux \
    neovim \
    ripgrep \
    fzf \
    htop \
    git \
    curl \
    wget \
    unzip \
    build-essential \
    python3 \
    python3-pip \
    xclip \
    xsel
