#!/bin/bash

set -u

THIS_DIR=$(cd $(dirname $0); pwd)

cd $THIS_DIR

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue

    echo "$f"
    ln -snfv "$THIS_DIR"/"$f" ~/
done

echo "installing Homebrew ..."
which brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "run brew doctor ..."
which brew >/dev/null 2>&1 && brew doctor

echo "run brew update ..."
which brew >/dev/null 2>&1 && brew update

echo "ok. run brew upgrade ..."
brew upgrade

brew bundle

brew cleanup

