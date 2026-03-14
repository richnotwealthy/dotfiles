#!/bin/bash
set -e

cd ~

# Clone dotfiles
git clone https://github.com/richnotwealthy/dotfiles.git

# Run install scripts
cd dotfiles
./install
./install-tools
