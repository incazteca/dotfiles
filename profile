# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set XTERM to xterm-256
if [ $TERM = "xterm" ] ; then
    TERM="xterm-256color"
fi

set -o vi

if [[ $(uname) == 'Darwin' ]]; then
	# SET CLI colors since OSX is lame and is just one color
	export CLICOLOR=1

	if [ -f $(brew --prefix)/etc/bash_completion ]; then
		. $(brew --prefix)/etc/bash_completion
	fi

	source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
fi

PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1)$ '

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.local/bin
