tmux_switcher() {
    session_name=$1

    if [$session_name == '']; then
        session_name='QA'
    fi
    tmux new-session -c ~/development_zone -s $session_name
}

db_disconnect() {
    db_name=$1
    psql postgres -c "select pg_terminate_backend(pid) from pg_stat_activity where datname='$1'"
}

vim_modified() {
    if [[ $(uname) == 'Darwin' ]]; then
        git status --short | awk '{print $2}' | xargs -o vim
    else
        git status --short | awk '{print $2}' | xargs bash -c '</dev/tty vim "$@"' i
    fi
}

alias vi='vim'
alias be='bundle exec'
alias tmux="TERM=screen-256color-bce tmux"
alias tmux-session=tmux_switcher
alias besty='bundle exec spring'
alias db-disconnect=db_disconnect
alias vim-modified=vim_modified
alias py-clean='find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf'
