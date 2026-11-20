# dotfiles


## Using GNU stow

GNU stow is not capable of replacing existing files.
Thus, you need to

```
cd
git clone https://github.com/victorusu/dotfiles .dotfiles
cd .dotfiles
stow --dotfiles --adopt -t ~/ bash
git restore bash
stow --dotfiles -t ~/ vim
stow --dotfiles -t ~/.config sway
git restore sway
```

GNOME-shell
```
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ next-tab '<Control>Tab'
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ prev-tab '<Control><Shift>Tab'
```

Git GPG via ssh keys
```
git config gpg.format ssh
git config user.signingkey ~/.ssh/id_ed25519.pub
git config commit.gpgsign true
```
