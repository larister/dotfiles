#!/bin/bash

cd ~
mkdir .oh-my-zsh
ln -s dotfiles/.gitconfig .gitconfig 
ln -s dotfiles/.gitignore .gitignore 
ln -s dotfiles/.bash_aliases .bash_aliases
ln -s dotfiles/.bash_profile .bash_profile
ln -s dotfiles/.vimrc .vimrc
ln -s dotfiles/.zshrc .zshrc
ln -s dotfiles/.p10k.zsh .p10k.zsh
ln -s dotfiles/.zprofile .zprofile
ln -s dotfiles/oh-my-zsh.sh .oh-my-zsh/oh-my-zsh.sh
