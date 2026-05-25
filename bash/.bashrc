#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Created by `pipx` on 2026-05-01 15:12:48
export PATH="$PATH:/home/gabri/.local/bin"
export PATH="$PATH:$(go env GOPATH)/bin"

# customization
PS1='\[\e[38;5;111m\]❯\[\e[38;5;110m\] \w\[\e[0m\] '

# fastfetch on startup
fastfetch
