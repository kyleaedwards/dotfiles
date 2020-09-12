# Enable italics in the terminal
tic -o $HOME/.terminfo misc/xterm-256color-italic.terminfo

# Install bat utility
brew install bat

# Install vim/nvim
brew install vim
brew install neovim --HEAD

wget https://github.com/rust-analyzer/rust-analyzer/releases/download/nightly/rust-analyzer-mac -O /usr/local/bin/rust-analyzer

# Install reattach-to-user-namespace
brew install reattach-to-user-namespace

# Setup custom home shell scripts
mkdir $HOME/.dfbin
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O $HOME/.dfbin/git-completion.bash
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O $HOME/.dfbin/git-prompt.sh

git clone https://github.com/sindresorhus/pure.git $HOME/.dfbin/pure

# Install vim-plug
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Enable .zshrc base
touch $HOME/.zshrc
if grep -q "GNOSIS_BOOTSTRAP" $HOME/.zshrc; then
    echo ".zshrc already extends base profile, skipping..."
else
    touch $HOME/tmp.zshrc
    echo "# BEGIN GNOSIS_BOOTSTRAP" >> $HOME/tmp.zshrc
    echo "source $HOME/dotfiles/zshrc" >> $HOME/tmp.zshrc
    echo "# END GNOSIS_BOOTSTRAP\n" >> $HOME/tmp.zshrc
    cat $HOME/.zshrc >> $HOME/tmp.zshrc
    cp $HOME/tmp.zshrc $HOME/.zshrc
    rm $HOME/tmp.zshrc
fi

# Enable .tmux.conf base
touch $HOME/.tmux.conf
if grep -q "GNOSIS_BOOTSTRAP" $HOME/.tmux.conf; then
    echo ".tmux.conf already extends base configuration, skipping..."
else
    touch $HOME/tmp.tmux.conf
    echo "# BEGIN GNOSIS_BOOTSTRAP" >> $HOME/tmp.tmux.conf
    echo "source-file $HOME/dotfiles/tmux" >> $HOME/tmp.tmux.conf
    echo "# END GNOSIS_BOOTSTRAP\n" >> $HOME/tmp.tmux.conf
    cat $HOME/.tmux.conf >> $HOME/tmp.tmux.conf
    cp $HOME/tmp.tmux.conf $HOME/.tmux.conf
    rm $HOME/tmp.tmux.conf
fi

# Enable .vimrc base
touch $HOME/.vimrc
if grep -q "GNOSIS_BOOTSTRAP" $HOME/.vimrc; then
    echo ".vimrc already extends base configuration, skipping..."
else
    touch $HOME/tmp.vimrc
    echo "\" BEGIN GNOSIS_BOOTSTRAP" >> $HOME/tmp.vimrc
    echo "source $HOME/dotfiles/vimrc" >> $HOME/tmp.vimrc
    echo "\" END GNOSIS_BOOTSTRAP\n" >> $HOME/tmp.vimrc
    cat $HOME/.vimrc >> $HOME/tmp.vimrc
    cp $HOME/tmp.vimrc $HOME/.vimrc
    rm $HOME/tmp.vimrc
fi

# Add dotfile global gitignore
GLOBAL_GITIGNORE="$(git config --global core.excludesfile)"
if [ -z GLOBAL_GITIGNORE ]; then
    git config --global core.excludesfile $HOME/.gitignore_global
    GLOBAL_GITIGNORE=$HOME/.gitignore_global
fi
touch $GLOBAL_GITIGNORE
cat $HOME/dotfiles/misc/gitignore >> $GLOBAL_GITIGNORE

