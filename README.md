Daniel's Dotfiles
=================

This repository contains the configuration files of a number of unix/linux utilities along with a set of deployment scripts that automate the process of configuring the host system.

*NOTE:* Several deployment scripts assume that this project is located at `~/.dotfiles`.

How to get up and running
-------------------------

    git clone git@github.com:dnjstrom/dotfiles.git ~/.dotfiles
		git submodule update --init --recursive
    chmod +x ~/.dotfiles/**/deploy.sh
    ~/.dotfiles/provision-all.sh
		vim -c "PlugUpdate | qa"

The above commands will apply all configuration contained in this repository to the host, replacing any existing setup. You can also run individual provision.sh scripts to apply configuration for only that utility. These provisioning scripts can be found in the corresponding subdirectory.
