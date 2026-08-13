```
# Assuming u have a fresh nixos install
nix-shell -p git stow
git clone https://github.com/randomdegenerate/dotfiles/
cd dotfiles
stow .
sudo nixos-rebuild switch ~/nixsystem/#GumiTeto
# now you have my jank ass setup
```
