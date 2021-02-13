tmux_switcher() {
    session_name=$1

    if [$session_name == '']; then
        session_name='QA'
    fi
    tmux new-session -c ~/development_zone -s "$session_name"
}

db_disconnect() {
    db_name=$1
    psql postgres -c "select pg_terminate_backend(pid) from pg_stat_activity where datname='$1'"
}

vim_modified() {
    if [[ $(uname) == 'Darwin' ]]; then
        git status --short | awk '{if ($1 == "M" || $1 == "UU"){print $2}}' | xargs -o vim
    else
        git status --short | awk '{if ($1 == "M" || $1 == "UU"){print $2}}' | xargs bash -c '</dev/tty vim "$@"' i
    fi
}

git_rebase_helper() {
  file_name=$1

  if [$file_name == '']; then
    git log --format=format:%H --name-only origin/master.. |
    awk '/^[a-z,0-9]{40}$/{prev=$0; getline; print $1 "--" substr(prev, 0, 7)}' |
    sort
  else
    git log --format=format:%H --name-only origin/master.. |
    awk '/^[a-z,0-9]{40}$/{prev=$0; getline; print $1 "--" substr(prev, 0, 7)}' |
    sort |
    grep $file_name |
    awk '{commit=substr($0,length($0) - 6); output=output"|"commit ; print output}' |
    tail -n 1
  fi
}

git_history_search() {
  expression=$1
  git rev-list --all | xargs git grep "$expression"
}

alias vi='vim'
alias be='bundle exec'
alias tmux="TERM=screen-256color-bce tmux"
alias tmux-session=tmux_switcher
alias besty='bundle exec spring'
alias db-disconnect=db_disconnect
alias vim-modified=vim_modified
alias git_rebase_helper=git_rebase_helper
alias git_history_search=git_history_search
alias py-clean='find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf'
alias notes='vi ~/.NOTES'
