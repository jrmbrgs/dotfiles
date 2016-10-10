
# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install vim


mkdir ~/.vim/backups
mkdir ~/.vim/swaps
mkdir ~/.vim/undo

ln -s ~/code/dotfiles/vimrc ~/.vimrc
ln -s ~/code/dotfiles/vim/syntax ~/.vim/syntax
ln -s ~/code/dotfiles/vim/colors ~/.vim/colors

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#Powerline fonts
cd ~/code
git clone git@github.com:powerline/fonts.git
./fonts/install.sh

sudo npm install -g jshint
sudo npm install -g eslint

(
export PKG=eslint-config-airbnb;
npm info "$PKG" peerDependencies --json | command sed 's/[\{\},]//g ; s/: /@/g' | xargs sudo npm install -g "$PKG"
)
ln -s ~/code/dotfiles/.eslintrc ~/.eslintrc
