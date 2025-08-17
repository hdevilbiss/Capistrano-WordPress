# Deploying Websites with Ruby

Barebones deployment over SSH using password-protected SSH keys, using WSL.

Official Capistrano README: [https://github.com/capistrano/capistrano/blob/master/README.md](https://github.com/capistrano/capistrano/blob/master/README.md)

## Day-to-day work

Add the SSH key that allows the development machine to "talk" to the remote server to your SSH forwarding agent, then run Capistrano commands.

1. For Windows, `wsl`.
1. `eval "$(ssh-agent -s)"`.
1. `ssh-add /mnt/c/Users/Username/.ssh/private_openssh`.
1. `bundle exec cap production deploy:check --trace`.
1. `bundle exec cap production deploy --dry-run`.
1. `bundle exec cap production deploy`.

## Prerequisites:

Ruby and Bundler need to be installed on development. I recently switched from using Windows PowerShell to Windows Subsystem for Linux.

1. Linux. `wsl`
1. Update Linux packages. `sudo apt update`
1. Upgrade Linux packages. `sudo apt upgrade`
1. Install Ruby. `sudo apt install ruby-full`
1. Install Bundler. `gem install bundler`
1. Bundle. `bundle install`.

## Notes related to SSH operations

- Linked files and directories need to exist on the remote. The [`rsync` command](https://gist.github.com/hdevilbiss/9ef364f2af6ecfafddecaaf457f8e253#remote-sync-) can be useful for this.
- A copy of the public key for SSH deployment needs to be in the `~/.ssh` folder or in the `~/.authorized_keys` file on the server.
    - This may be true for GitHub-specific SSH key(s) as well.
- The file `~/.composer/auth.json` file might also need to be setup for private repositories auto-installed using Composer.