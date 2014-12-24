#!/usr/bin/env bash

# Retrieve list of dotfiles

current_date=`date +%Y%m%d`

dotfiles=($(find . -maxdepth 1 -type f ! -name '*.sh' -a ! -name '*.md' -a ! -name '*.swp' -printf '%f\n'))

# TODO: Pop out first entry in dot directories since it is the current directory
dot_directories=($(find . -maxdepth 1 -type d ! -name 'backups' -a ! -name '.git' -a ! -name '.' -printf '%f\n'))

echo ${dotfiles[@]}
echo ${dot_directories[@]}
# Backup dotfiles in backup directory


