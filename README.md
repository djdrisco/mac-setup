# CFPB Mac setup scripts

Configurations and scripts for setting up a new developer Mac.
This is a fork from github.com/cfpb/mac-setup.

## Automated software setup

The `dave_provision_tools.sh` script installs a standard developer environment
on new Mac computers, with the goal of making the machine ready to set up
[cfgov-refresh](https://github.com/cfpb/cfgov-refresh) for local development.
This includes, but is not limited to:

- [Homebrew](http://brew.sh/)
- Up-to-date or cfgov-refresh-specific versions of several core developer tools:
  - Git (replacing Apple Git)
  - pyenv and pyenv-virtualenvwrapper with Python 3.6.9
  - nvm with the latest LTS release of Node (Node install)
  - Yarn with the following installed globally:

- Minimal dotfiles with the necessary bits for all of the above to work as expected

### Running the script

1. Run the following command from the root of this repository
   to initiate the installation: `./dave_provision_tools.sh`.
1. After the script completes, run `source ~/.bashrc`
   to apply the changes to your current terminal session,
   or just close the session and open a new one.

### Backups

- If any dotfiles (`~/.bash_profile`, `~/.bashrc`, etc.) would be overwritten,
  they will be backed up to `~/<filename>_<date>`.
- If you have anything in your `~/.git-templates/` folder and
  your global `.gitconfig` has `init.templateDir` value is set to that location,
  your files will be left in place
  and the `init.templateDir` will be changed to `~/.git-templates/git-secrets/`.


