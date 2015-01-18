tmux_switcher() {
    session_name=$1

    if [$session_name == '']; then
        session_name='QA'
    fi
    tmux new-session -c ~/development_zone -s $session_name
}

alias be='bundle exec'
alias tmux="TERM=screen-256color-bce tmux"
alias tmux-session=tmux_switcher
alias besty='bundle exec spring'
