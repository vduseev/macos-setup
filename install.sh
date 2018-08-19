#!/bin/bash

# Verify that user belongs to the admin group
if ! id -Gn $(whoami) | grep -q -w admin; then
  echo 'ERROR: This script must be ran by the admin user.'
  exit 1
fi 

# Verify script is ran from the terminal
if ! [ -t 1 ]; then
  echo 'ERROR: The script is tailored to be ran from the terminal.'
  exit 1
fi

# Change work directory to the user's home
cd ~

# Start with cloning the repository
git clone https://github.com/vduseev/macos-setup.git ~/Source/macos-setup
chown -R $(whoami) ~/Source
