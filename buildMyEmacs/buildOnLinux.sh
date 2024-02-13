#!/bin/bash

cDir=$(pwd)

sudo add-apt-repository ppa:ubuntu-toolchain-r/ppa
sudo apt-get update

sudo apt-get install gcc-10 libgccjit0 libgccjit-10-dev apt-transport-https ca-certificates curl gnupg-agent software-properties-common libjansson4 libjansson-dev libxpm-dev libjpeg-dev libgif-dev libtiff-dev libgnutls28-dev

sudo apt-get build-dep emacs

git clone https://git.savannah.gnu.org/git/emacs.git
git clone git@github.com:tree-sitter/tree-sitter.git

cd tree-sitter
make
make install

cd ${cDir}/emacs
./autogen.sh
./configure --without-compress-install --with-native-compilation --with-json --with-mailutils --with-tree-sitter --with-small-ja-dic CC=gcc-10

make -j$(nproc)
make install

