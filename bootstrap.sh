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

# Start with cloning the repositories
echo -e "\033[1;32m[NOTICE  ] Cloning macos-setup to the temporary location...\033[0m"
git clone https://github.com/vduseev/macos-setup.git "${TMPDIR}macos-setup"
#git clone https://github.com/niieani/bash-oo-framework.git "${TMPDIR}bash-oo-framework"

(
  # Activate bash logging library
  source "${TMPDIR}macos-setup/lib/b-log.sh"
  LOG_LEVEL_ALL

  NOTICE "Running verification checks..."

  # Verify that user belongs to the admin group
  if ! id -Gn $(whoami) | grep -q -w admin; then
    FATAL "ERROR: This script must be ran by the admin user."
    exit 1
  fi 

  # Verify script is ran from the terminal
  if ! [ -t 1 ]; then
    FATAL "ERROR: The script is tailored to be ran from the terminal."
    exit 1
  fi
)

# Copy the framework files from repo and erase it
#cp -R "${TMPDIR}bash-oo-framework/lib" "${TMPDIR}macos-setup"
#rm -rf "${TMPDIR}bash-oo-framework"

# Activate bash-oo-framework
#source "${TMPDIR}macos-setup/lib/oo-bootstrap.sh"

# Enable try-catch and exception printing functionality
#import util/tryCatch
#import util/exception

#try {
  ## Launch installation script
  #exec "${TMPDIR}macos-setup/install.sh"
#} catch {
  #echo "Caught Exception:$(UI.Color.Red) $__BACKTRACE_COMMAND__ $(UI.Color.Default)"
  #echo "File: $__BACKTRACE_SOURCE__, Line: $__BACKTRACE_LINE__"

  #Exception::PrintException "${__EXCEPTION__[@]}"
#}

(
  exec "${TMPDIR}macos-setup/install.sh"
)

# Perform final cleanup
echo -e "\033[1;32m[NOTICE  ] Removing macos-setup from the temporary location...\033[0m"
rm -rf "${TMPDIR}macos-setup"
