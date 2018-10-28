# macOS Development System Deployment

This repository provides automated scripts, instructions, and playbooks to set up a macOS based development environment from scratch in one step.

Based on:
   - [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook)
   - [High Sierra VirtualBox instructions](https://tobiwashere.de/2017/10/virtualbox-how-to-create-a-macos-high-sierra-vm-to-run-on-a-mac-host-system/)
   - [Mojave VirtualBox instructions](https://github.com/AlexanderWillner/runMacOSinVirtualBox)

## Usage

1. Install Apple's Xcode command line tools using `xcode-select --install`
2. Launch the whole installation using

   ```console
   curl -L duseev.com/macos | bash
   ```

   This step downloads and executes a *bash* script from GitHub. `-L` is there simply to follow the permanent redirect. 

## List of major components
* System tools (CLI)
* Tools (GUI)
* Communication (GUI)

### System tools
* Homebrew
* Xcode
* VirtualBox
* Docker
* CMake
* iTerm2
* tmux
* MacVim
* TunnelBlick (for SailPlay connection)
* smcFanControl
* Ansible
* Vagrant
* PlantUML
* Graphviz for PlantUML
* Interpreters must be completely ISOLATED!!!
  * Java installed manually or via SDKMan
  * Python via `pyenv` and `pipenv`
  * Ruby via `rbenv` 
    * Bundler for each version of Ruby
* AWS CLI installed via `pipenv` under `.aws`
 
### Settings
* GPG Keys
* git config
* SSH keys
* Vim Config
* VPN configs
  * IPVanish
  * TunnelBlick connection
* Fish shell
  * Aliases
  * Variables
  * Fisherman
  * oh-my-fish
  * User defined functions (like gs, ga, gp)


### GUI tools
* Google Chrome
* Atom
* VSCode
* JetBrains Tools
* Photoshop
* Spotify
* qBitTorrent
* VLC Media Player
* Microsoft Office
* Parallels
* Magnet (Window align tool from AppStore)

### Communication
* Skype 
