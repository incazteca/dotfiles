tmux_switcher() {
    session_name=$1

    if [$session_name == '']; then
        session_name='QA'
    fi
    tmux new-session -c ~/development_zone/8b/apps -s $session_name
}

alias be='bundle exec'
alias tmux-session=tmux_switcher
alias besty='bundle exec spring'
