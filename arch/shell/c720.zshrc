# vim:ft=zsh
# to heavy perl -Mutf8::all
alias perl='perl -CASD -Mutf8 -M-strict -Mv5.18'

alias bb='PATH="$HOME/opt/busybox/:$PATH" zsh'
alias zb="tmux setw visual-activity off &&
          tmux neww -a -n zsh-new 'ZDOTDIR=/home/yazu/work/zshrc zsh'"

