# From Ubuntu (ancient)
########################################################################
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# umask 022

# Why?
# # if running bash
# if [ -n "$BASH_VERSION" ]; then
#     # include .bashrc if it exists
#     if [ -f "$HOME/.bashrc" ]; then
# 	. "$HOME/.bashrc"
#     fi
# fi

## END Ubuntu 

ETC=$HOME/usr/etc
LIB=$HOME/usr/lib
VAR=$HOME/var
NOTES=$HOME/usr/notes
export ETC LIB VAR NOTES

prepend_path () {
    case ":$PATH:" in
        *:"$1":*) ;;
        "::") PATH="$1" ;;
        *) PATH="$1:$PATH" ;;
    esac
}

[ -e "$VAR/profile.d" ] && [ "$(ls "$VAR/profile.d")" ] \
    && for f in "$VAR/profile.d/"*; do . $f; done 

# for Manjaro (and Arch?)
# export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"

prepend_path "$HOME/.local/bin"
prepend_path "$HOME/bin"

export PATH
