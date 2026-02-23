#!/bin/bash
# Installera/uppdatera zsh-plugins
# run_onchange_ = körs om skriptets innehåll ändras

set -e

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# zsh-autosuggestions
if [ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git -C "$ZSH_CUSTOM/plugins/zsh-autosuggestions" pull --quiet
else
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# zsh-syntax-highlighting
if [ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git -C "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" pull --quiet
else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting \
        "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi
