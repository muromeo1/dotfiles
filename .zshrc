# Will append brew to linux based systems
if [[ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"
plug "wintermi/zsh-starship"
plug "chivalryq/git-alias"

alias bex='bundle exec'
alias rc='bex rails c'
alias rs='bex rails s'
alias k='kubectl'

if type rg &> /dev/null; then
	export IGNORED_FOLDERS='.git,node_modules,vendor,tmp,cache,package-lock.json'
	export FZF_IGNORED_FOLDERS="--glob '!{$IGNORED_FOLDERS}'"
	export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow $FZF_IGNORED_FOLDERS"
	export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

# Ctrl + space to clear screen
bindkey '^ ' clear-screen

export EDITOR=nvim
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

. "$HOME/.asdf/asdf.sh"

source <(fzf --zsh)

# Load and initialise completion system
autoload -Uz compinit
compinit


# opencode
export PATH=/Users/muriloromeo/.opencode/bin:$PATH
