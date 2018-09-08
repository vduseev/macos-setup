#!/usr/bin/env bash

# bootstrap.sh
# This is a bootstrap script intended to be downloaded and launched
# in one step.
# It downloads required files and starts the installation script.
#
# Strategy:
# - Run basic verifications
#   - Are running as an admin user
#   - Are we running from a terminal
# - Git clone the setup repository and bash enhancement framework
#   - Just clone the setup repository
#   - Clone bash-oo-framework
#   - Copy `lib` folder to the setup repository
#   - Remove cloned bash-oo-framework
# - Launch install script

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

# Start with cloning the repositories
git clone https://github.com/vduseev/macos-setup.git $TMPDIR/macos-setup
git clone https://github.com/niieani/bash-oo-framework.git $TMPDIR/bash-oo-framework

# Copy the framework files from repo and erase it
cp $TMPDIR/bash-oo-framework/lib $TMPDIR/macos-setup
rm -rf $TMPDIR/bash-oo-framework

# Launch installation script
$TMPDIR/macos-setup/install.sh
