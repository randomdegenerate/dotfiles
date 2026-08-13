```
# Assuming u have a fresh nixos install

# temporarly inject required dependencies to install and setup configuration into a new shell
nix-shell -p git stow
# clone rep and go into the folder
git clone https://github.com/randomdegenerate/dotfiles/
cd dotfiles
# copy hardware-configuration.nix cause those are machine specific
sudo cp /etc/nixos/hardware-configuration.nix ./nixsystem/nixos/hardware-configuration.nix
# copy files from repo to home directory as symlinks
stow .
# rebuild system with my system config's flake name
sudo nixos-rebuild switch ~/nixsystem/#GumiTeto
# exit nix shell
exit

# now you have my jank ass setup(WIP)
```
