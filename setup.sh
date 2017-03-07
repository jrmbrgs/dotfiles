#

# Because of mac /Users and unix /home
cd ~/

# Base dotfiles
for f in .bash_aliases .bash_funcs .bash_profiles .bash_prompt .bashrc; do
    ln -s code/dotfiles/$f $f
done

# Install brew
brew=$(brew -v)
if [ -d /Users -a $? -ne 0 ]; then
    echo Installing brew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo Brew already installed
fi

# VIm
vi=$(vim --version)
if [ $? -ne 0 ]; then
    echo Installing Vim
    brew install vim
else
    echo Vim already installed
fi
mkdir ~/.vim/backups
mkdir ~/.vim/swaps
mkdir ~/.vim/undo
ln -s code/dotfiles/.vimrc .vimrc
cd ~/.vim
ln -s ../code/dotfiles/vim/syntax syntax
ln -s ../code/dotfiles/vim/colors colors
cd ~

## Plug
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    echo Installing Vim Plug ...
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo Vim Plug already installed
fi
## Powerline fonts
if [ ! -d ~/code/fonts ]; then
    echo Installing PowerFonts ...
    git clone git@github.com:powerline/fonts.git ~/code/fonts
    ~/code/fonts/install.sh
else
    echo PowerFonts installed
fi

# Ctags
if [ ! -d /usr/local/Cellar/ctags ]; then
    echo Installing Ctags
    brew install ctags
else
    echo Ctags already installed
fi

# Z
if [ ! -d ~/code/z ]; then
    echo Installing Z ...
    git clone git@github.com:rupa/z.git ~/code/z
else
    echo Z already installed
fi

# Fzf
Fzf=$(Fzf --version)
if [ $? -ne 0 -a -d /Users]; then
    echo Installing Fzf for osx
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/code/fzf.osx
    ~/code/fzf.osx/install --bin
elif [ $? -ne 0]; then
    echo Installing Fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/code/fzf
    ~/code/fzf/install --bin
else
    echo Fzf already installed
fi

# Git
ln -s code/dotfiles/.gitconfig .gitconfig

# TheFuck
thefuck=$(thefuck -v)
if [ -d /Users -a $? -ne 0 ]; then
    echo Installing Thefuck
    brew install thefuck
elif [ -d /home -a $? -ne 0 ]; then
    sudo apt install python3-dev python3-pip
    sudo -H pip3 install thefuck
else
    echo Thefuck already installed
fi

echo enjoy
exit;
sudo npm install -g jshint
sudo npm install -g eslint

(
export PKG=eslint-config-airbnb;
npm info "$PKG" peerDependencies --json | command sed 's/[\{\},]//g ; s/: /@/g' | xargs sudo npm install -g "$PKG"
)
ln -s ~/code/dotfiles/.eslintrc ~/.eslintrc
