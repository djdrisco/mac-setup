#!/bin/bash


# Install Homebrew, "the missing package manager for macOS".
# https://brew.sh/
#
# Installing in home directory against the standard advice,
# because we don't have access to their preferred location (/usr/local).
echo -e "\033[44;97m!¡!¡! CFPB Mac Setup !¡!¡! INSTALLING HOMEBREW ¡!¡!¡\033[0m"
mkdir $HOME/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/homebrew

## Update path for this script to be able to access the brew command.
export PATH="${HOME}/homebrew/bin:${PATH}"


# Install standard Brew formulae that most devs will need or want.
# Git, in particular, give us a more modern version than what ships with macOS.
echo -e "\033[44;97m!¡!¡! CFPB Mac Setup !¡!¡! INSTALLING STANDARD BREW FORMULAE ¡!¡!¡\033[0m"
echo "!¡!¡! (This will take a while. Stretch your legs.)"
#brew install git git-secrets pyenv pyenv-virtualenvwrapper
#edit just install python for now
brew install pyenv pyenv-virtualenvwrapper


# Set up Python environment.
# Following the instructions at:
# https://github.com/cfpb/development/blob/master/guides/installing-python.md
echo -e "\033[44;97m!¡!¡! CFPB Mac Setup !¡!¡! INITIALIZING PYENV ¡!¡!¡\033[0m"

## Export necessary environment variables for use in this script.
export PYENV_ROOT="${HOME}/.pyenv"
export WORKON_HOME="${HOME}/.virtualenvs"
export NODE_VERSION=8.9.3

## Initialize pyenv for this script to be able to use it.
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

## Install the version of Python that we use.
export PY3_VER="3.6.9"
echo -e "\033[44;97m!¡!¡! CFPB Mac Setup !¡!¡! INSTALLING PYTHON ${PY3_VER} ¡!¡!¡\033[0m"
pyenv install ${PY3_VER}

## Set the global Python versions.
echo -e "\033[44;97m!¡!¡! CFPB Mac Setup !¡!¡! SETTING GLOBAL PYTHON VERSION ¡!¡!¡\033[0m"
pyenv global ${PY3_VER}

# Install NVM (Node Version Manager).
# https://github.com/nvm-sh/nvm
echo -e "\033[44;97m!¡!¡! CFPB Mac Setup !¡!¡! INSTALLING NVM ¡!¡!¡\033[0m"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

## Export necessary environment variable for use in this script.
export NVM_DIR="${HOME}/.nvm"

## Initialize NVM for this script to be able to use it.
if [ -s "$NVM_DIR/nvm.sh" ]; then
  source "$NVM_DIR/nvm.sh"
fi

## Install the latest LTS (long-term support) release of Node and but use specific version.
echo -e "\033[44;97m!¡!¡! CFPB Mac Setup !¡!¡! INSTALLING NODE ¡!¡!¡\033[0m"
nvm install lts/*
nvm install $NODE_VERSION
nvm alias default $NODE_VERSION
nvm use default

# Install the Yarn package manager.
# https://yarnpkg.com/
#
# This will automatically add it to the PATH by appending .bashrc.
echo -e "\033[44;97m!¡!¡! CFPB Mac Setup !¡!¡! INSTALLING YARN ¡!¡!¡\033[0m"
curl -o- -L https://yarnpkg.com/install.sh | bash

## Update path for this script to be able to access the yarn command.
export PATH="${HOME}/.yarn/bin:${HOME}/.config/yarn/global/node_modules/.bin:${PATH}"

## Install global Node packages.
echo -e "\033[44;97m!¡!¡! CFPB Mac Setup !¡!¡! INSTALLING GLOBAL NODE PACKAGES ¡!¡!¡\033[0m"
yarn global add yo

# Apply standard dotfiles, backing up existing files if present.
echo -e "\033[44;97m!¡!¡! CFPB Mac Setup !¡!¡! CREATING STANDARD DOTFILES ¡!¡!¡\033[0m"
echo "!¡!¡! Note: Existing files will be backed up in the same location with a suffix of the date."
rsync -abq --suffix=_`date +"%Y%m%d_%H%M"` ./dotfiles/ $HOME/

# Add global Git config for .gitmessage.
git config --global commit.template $HOME/.gitmessage

echo -e "\033[44;97m!¡!¡! CFPB Mac Setup !¡!¡! SETUP COMPLETE! ¡!¡!¡\033[0m"
echo "!¡!¡! Be sure to source ~/.bashrc or open a new terminal window."
