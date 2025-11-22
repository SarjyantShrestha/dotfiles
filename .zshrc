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

# Ctrl-K = history up (previous command)
bindkey '^K' up-line-or-history

# Ctrl-J = history down (next command)
bindkey '^J' down-line-or-history

# Ctrl-K = search up
bindkey '^K' history-substring-search-up

# Ctrl-J = search down
bindkey '^J' history-substring-search-down

