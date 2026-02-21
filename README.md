# dotfiles

My personal config files

![Image](/screenshots/screenshot1.png?raw=true)

## Contents

- vim config
- tmux config
- zsh config

## Setup

### Dependencies

- [stow](https://github.com/aspiers/stow) (optional)
- [git](https://wiki.archlinux.org/title/git)
- [vim](https://www.vim.org) > **8**
- [tmux](https://wiki.archlinux.org/title/tmux) > **2.6**
- [zsh](https://wiki.archlinux.org/title/zsh)
- A [Nerd Font](https://www.nerdfonts.com/) as your terminal font.

### Installation

```bash
mkdir ~/.config
git clone https://github.com/iammucahit/dotfiles.git
cd dotfiles
stow tmux zsh vim
```

## External Dependencies

### zsh

- [fzf](https://github.com/junegunn/fzf) >= **0.48.0**
- [zoxide](https://github.com/ajeetdsouza/zoxide)

### vim

- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
- [win32yank](https://github.com/equalsraf/win32yank) (for wsl)


## Notes

- tmux prefix keymap is `` ` `` (backtick)
- arrow keys disabled in vim
- no plugin manager used
- terminal theme not included
- vim leader key is " " (space)