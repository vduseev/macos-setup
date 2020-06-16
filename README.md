# macOS Development System Deployment

This repository provides automated scripts, instructions, and playbooks to set up a macOS based development environment from scratch in one step.

## Usage

### One-lines
1. Install Apple's Xcode command line tools using `xcode-select --install`
2. Launch the whole installation using

   ```console
   curl -L duseev.com/macos | bash
   ```

   This step downloads and executes a *bash* script from GitHub. `-L` is there simply to follow the permanent redirect. 

### Configurable Launch 
1. Install Apple's Xcode command line tools using `xcode-select --install`
2. Checkout https://github.com/vduseev/macos-setup repo
3. Modify `macos-setup/configuration/` the way you want
4. Run `./bootstrap.sh --no-repo`

## Architecture

### macos setup
Consists of:

1. macos-setup (macos-specific public playbook)
1. dotfiles (cross-platform public config)
1. config (cross-platform private config)

### linux setup
1. dotfiles (cross-platform public config)
1. config (cross-platform private config)

## Based on
- [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook)
- [High Sierra VirtualBox instructions](https://tobiwashere.de/2017/10/virtualbox-how-to-create-a-macos-high-sierra-vm-to-run-on-a-mac-host-system/)
- [Mojave VirtualBox instructions](https://github.com/AlexanderWillner/runMacOSinVirtualBox)

