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
        'w0rp/ale'
        'fatih/vim-go'
        'Yggdroot/indentLine'
        'scrooloose/nerdtree'
        'tpope/vim-endwise'
        'tpope/vim-fugitive'
        'tpope/vim-haml'
    )

    for plugin in ${vim_plugins[@]}; do
        IFS=-/ read -r author plugin_name <<<"$plugin"

        install_path=$current_path/vim/bundle/$plugin_name

        if [ ! -e $install_path ]; then
            echo "Installing $plugin"
            git clone https://github.com/$plugin $install_path
        fi
    done
}

function setup_dotfiles {
    echo "Backing up existing dotfiles"

    timestamp=`date +%Y%m%d%H%M%S`

    declare -a dotfiles

    if [[ $(uname) == 'Darwin' ]]; then
        dotfiles=($(gfind . -maxdepth 1 -type f ! -name '*.sh' -a ! -name '*.md' -a ! -name '.*' -printf '%f\n'))
    else
        dotfiles=($(find . -maxdepth 1 -type f ! -name '*.sh' -a ! -name '*.md' -a ! -name '.*' -printf '%f\n'))
    fi

    current_path=$(pwd)

    for dotfile in ${dotfiles[@]}; do
        if [ -e $HOME/"."$dotfile ]; then
            mv $HOME/"."$dotfile $current_path"/backups/"$timestamp$dotfile
        fi

        echo "Setting up "$dotfile
        ln -s $current_path/$dotfile $HOME/"."$dotfile
    done
}

function setup_dot_directories {
    echo "Backing up existing dot directories"

    timestamp=`date +%Y%m%d%H%M%S`

    declare -a dot_directories

    if [[ $(uname) == 'Darwin' ]]; then
        dot_directories=($(gfind . -maxdepth 1 -type d ! -name 'backups' -a ! -name '.git' -a ! -name '.' -printf '%f\n'))
    else
        dot_directories=($(find . -maxdepth 1 -type d ! -name 'backups' -a ! -name '.git' -a ! -name '.' -printf '%f\n'))
    fi

    current_path=$(pwd)

    for dot_directory in ${dot_directories[@]}; do
        if [ -d $HOME/"."$dot_directory ]; then
            mv $HOME/"."$dot_directory $current_path"/backups/"$timestamp$dot_directory
        fi

        echo "Setting up "$dot_directory
        ln -s $current_path/$dot_directory $HOME/"."$dot_directory
    done
}

# Begin Main

install_pathogen
setup_vim_plugins

setup_dotfiles
setup_dot_directories
