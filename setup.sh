#!/usr/bin/env bash

function install_pathogen {
    echo "Installing Pathogen"

    current_path=$(pwd)
    curl -LSso $current_path/vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
}

function setup_vim_plugins {
    echo "Installing Vim Plugins"

    current_path=$(pwd)
    vim_plugins=(
        'scrooloose/syntastic'
        'scrooloose/nerdtree'
        'tpope/vim-endwise'
        'tpope/vim-fugitive'
        'tpope/vim-haml'
    )

    for plugin in ${vim_plugins[@]}; do
        echo "Installing $plugin"
        IFS=-/ read -r author plugin_name <<<"$plugin"

        git clone git@github.com:$plugin $current_path/vim/bundle/$plugin_name
    done
}

# Begin Main

install_pathogen
setup_vim_plugins

# Retrieve list of dotfiles

current_date=`date +%Y%m%d`

dotfiles=($(find . -maxdepth 1 -type f ! -name '*.sh' -a ! -name '*.md' -a ! -name '*.swp' -printf '%f\n'))

# TODO: Pop out first entry in dot directories since it is the current directory
dot_directories=($(find . -maxdepth 1 -type d ! -name 'backups' -a ! -name '.git' -a ! -name '.' -printf '%f\n'))

#echo ${dotfiles[@]}
#echo ${dot_directories[@]}


# Backup dotfiles in backup directory


