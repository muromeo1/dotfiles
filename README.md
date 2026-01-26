## Dotfiles

Automatically install a nerdy env with some cool stuff:

- 🖥️ [Zsh](https://www.zsh.org/)
- 🚀 [Starship](https://starship.rs/)
- 💤 [LazyVim](https://www.lazyvim.org/)
- 🔥 [Tmux](https://github.com/tmux/tmux/wiki)
- 🐱 [Kitty](https://sw.kovidgoyal.net/kitty/)
- 🤖 [OpenCode](https://opencode.ai/)
- 🐈 [Catppuccin](https://github.com/catppuccin/catppuccin)

Also uses [Stow](https://www.gnu.org/software/stow/manual/stow.html) to easy keep track of changes in this dotfiles.

## Screenshots

<img width="1913" height="1004" alt="image" src="https://github.com/user-attachments/assets/94ec633a-6eb0-4fac-b0ce-ed7b5303bb28" />
<img width="1913" height="1005" alt="image" src="https://github.com/user-attachments/assets/5934c0c0-c811-4949-8641-88e6648381c0" />

## Installation

1 - Install brew

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Note: for linux installations, set the PATH on

```
echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >> ~/.profile

source ~/.bashrc
source ~/.profile
```

2 - Install ZSH

```
brew install zsh
zsh
```

3 - Clone repo

```zsh
git clone https://github.com/muromeo1/dotfiles.git
```

4 - Run install script

```zsh
cd ~/dotfiles/
sh install.sh
```

5 - Close and reopen terminal, or

```zsh
source ~/.zshrc
```

6 - Set JetBrainsNerdFont as the font to terminal

7 - Change terminal color to #181725

#### (Optional)

Configure git

```zsh
sh configure_git.sh
```
