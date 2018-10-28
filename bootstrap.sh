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
# - Launch install script

#################################################
#         LOGGING METHODS AND CONSTANTS         #
#################################################

RED="\033[0:31m"
GREEN="\033[1:32m"
NC="\033[0m"  # No Color

info() {
  echo -e "[INFO  ] $1"
}
notice() {
  echo -e "${GREEN}[NOTICE]${NC} $1"
}
error() {
  echo -e "${RED}[ERROR ]${NC} $1"
}

##################################################
#                    MAIN LOGIC                  #
##################################################

main() {
  # Development mode: dev, prod
  local __mode=$1

   # Perform basic verifications
  if ! run_checks; then exit 1; fi

  # Clone main repository
  if ! clone_repository_to_tmp_dir $__mode; then exit 1; fi

  # Install required software
  if ! install; then exit 1; fi

  # Perform final cleanup
  if ! cleanup_tmp_dir; then exit 1; fi
}

#################################################
#                 HELPER METHODS                #
#################################################

# Run verification checks:
# 1. Verify that script is ran by admin user
# 2. Verify that script has been started from the terminal
#
run_checks() {
  notice "Running verification checks ..."

  # Verify that user belongs to the admin group
  if ! id -Gn $(whoami) | grep -q -w admin; then
    error "This script must be ran by the admin user."
    return 1
  fi 

  # Verify script is ran from the terminal
  if ! [ -t 1 ]; then
    error "The script is tailored to be ran from the terminal."
    return 1 
  fi

  return 0
}

# Clone macos-setup repository to the tmp directory
# to proceed further with the installation.
# If script is running in "dev" mode, then instead
# of clonning just copy files from script directory
# to the tmp directory.
#
# Arguments:
#   mode - "dev" or "prod"
#
# Returns:
#   0 if success
#   1 if failure
#
clone_repository_to_tmp_dir() {
  # If mode is "dev", then don't clone the repo
  local __mode=$1

  # Returns script's directory
  local __script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
  WORK_DIR="${TMPDIR}macos-setup"

  # Start with cloning the repositories
  notice "Cloning macos-setup to the temporary location ..."
  notice "${WORK_DIR}"

  # Use local directory instead of the remote one 
  # if mode is set to "dev" 
  if [ "$__mode" == "dev" ]; then

    # If STR="/path/to/foo.cpp", then
    # ${STR##*/} returns foo.cpp (basepath)
    if [ "${__script_dir##*/}" == "macos-setup" ]; then
      # Copy current directory to work dir
      cp -R . "${WORK_DIR}"
      cd "${WORK_DIR}"
      # Switch to "dev" branch
      git checkout dev
    else
      error "Can't run in DEV mode outside of macos-setup directory!"
      return 1
    fi

  else

    # Clone the repository from master the normal way
    git clone https://github.com/vduseev/macos-setup.git "${WORK_DIR}"
    cd "${WORK_DIR}"

  fi

  return 0
}

# Make sure that the temporary directory to which the files have been
# copied is always cleaned up after work is done.
cleanup_tmp_dir() {
  notice "Removing macos-setup from the temporary location ..."
  rm -rf "${WORK_DIR}"
}

install() {
   ensure_pip
   ensure_ansible

   return 1
}

ensure_pip() {
   notice "Making sure pip is installed ..."
   if hash pip 2>/dev/null; then
     info "pip is already installed"
     printf "$(pip --version)\n"
   else
     info "pip not found. Installing pip ..."
     sudo easy_install pip
   fi
}

ensure_ansible() {
   notice "Making sure ansible is installed ..."
   if hash ansible 2>/dev/null; then
     info "ansible is already installed"
     printf "$(ansible --version)\n"
   else
     info "ansible not found. Installing ansible ..."
     sudo -H pip install ansible
   fi
}

# Run main function
main $1
