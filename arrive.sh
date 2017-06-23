#!/bin/bash

CONFIG_PATH="~/.config/"

LINKED_FILES=(
  pylintrc
  zshrc
)

PROGRAMS=(
  zsh
  vim
  neovim
  haskell-platform
  git
  gcc
  ghc
  g++
  golang
  direnv
  python
  python-pip
  python3
  python3-pip
  python-dev
  nodejs
  npm
  ipython
  swi-prolog
  mosh
)

PYTHON_PACKS=(
  setuptools
  virtualenv
  flask
  numpy
  pandas
  scikit-learn
  tensorflow
  tensorflow-gpu
  jupyter
  https://github.com/joh/when-changed/archive/master.zip
)

HASKELL_PACKS=(
  base
  hoogle
  parallel
  hspec
)

NPM_PACKS=(
  marked
  meteor
  mocha
  react
  underscore
)


# Add apt-repos
# sudo add-apt-repository ppa:neovim-ppa/stable

# start at home
cd
echo "Linking Dot-files"
for FILE in "${LINKED_FILES[@]}"
do
    ln -s "$CONFIG_PATH$FILE" ".$FILE"
done

if hash brew 2>/dev/null; then
  echo "Installing Software"
  brew cask install --appdir="/Applications" ${PROGRAMS[@]}
else
  echo "Updating Apt"
  sudo apt-get update
  echo "Installing Software"
  sudo apt-get -f install ${PROGRAMS[@]}
fi

echo "Installing Python Libraries"
pip install --upgrade pip
pip install ${PYTHON_PACKS[@]}

#echo "Installing Haskell Packages"
#cabal update
#cabal install ${HASKELL_PACKS[@]}

#Install stack
curl -sSL https://get.haskellstack.org/ | sh


echo "Install NPM Packages"
npm update
npm install ${NPM_PACKS[@]} -g

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo "Starting zsh"
zsh
