# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting history-substring-search)

source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"

# Ctrl Space to accept autosuggest
bindkey '^ ' autosuggest-accept


# Ctrl-K = search up
bindkey '^P' history-substring-search-up

# Ctrl-J = search down
bindkey '^N' history-substring-search-down

alias cd=z

# pnpm
export PNPM_HOME="/home/arch/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

#mise
eval "$(~/.local/bin/mise activate zsh)"

eval "$(zoxide init zsh)"

. "$HOME/.local/share/../bin/env"
eval "$(uv generate-shell-completion zsh)"

source /usr/share/nvm/init-nvm.sh

