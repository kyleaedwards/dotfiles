# Language
LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  git-prompt
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Default Editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Establish TERMINFO color scheme
export TERM=xterm-256color-italic

# Prompt
fpath+=$HOME/.dfbin/pure
autoload -U promptinit; promptinit
prompt pure
export PURE_PROMPT_SYMBOL='λ ▸'
export PURE_PROMPT_VICMD_SYMBOL='µ ▸'

# Aliases
alias cat='bat'
alias gitopen='open "$(git ls-remote --git-url origin)"'
alias history=omz_history
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -laGh'
alias ls='ls -G'
alias md='mkdir -p'
alias src='source ~/.zshrc'
alias srcc='src && clear'
alias which-command=whence

# Bash Functions
mkcd() { mkdir -p "$@" && cd "$@"; }

# Contexts

# Context: nodejs
# export PATH="$HOME/.nvm/versions/node/v10.19.0/bin:$PATH"
# export NVM_DIR="$HOME/.nvm"
# export NVM_CD_FLAGS=-q
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Golang
export GOPATH=~/go/bin
export PATH=/usr/local/go/bin:$GOPATH:$PATH

# Python
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
export PATH=$PATH:~/pyenvs/neovim/env/bin

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Fuzzy Finding
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Remap vim
alias vvim='/usr/local/bin/vim'
alias vim='nvim'
alias nv='nvim'

# Allow vi keybindings in zsh
bindkey -v

# Always open in Tmux
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

