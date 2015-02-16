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

alias be='bundle exec'
alias tmux-session=tmux_switcher
alias besty='bundle exec spring'
alias db-disconnect=db_disconnect
