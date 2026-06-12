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
