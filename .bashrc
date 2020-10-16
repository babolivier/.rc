source /etc/bash.bashrc

export GOPATH="/home/brendan/go"
export EDITOR="vim"

# Path

export PATH="$PATH:/usr/local/bin/matlab"
export PATH="/usr/sbin:/sbin:/bin:/usr/games:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$PATH:/bin"
export PATH="$PATH:/home/brendan/.gem/ruby/2.5.0/bin"

# Shortcuts

alias spaces2tab='grep -Er "*+" --exclude-dir={.git,node_modules,vendor} --exclude="*.yml" --exclude="*.md" --exclude=".gitignore" | grep ":" | cut -d":" -f1 | sort -u | xargs sed -Ei "s/^    /\t/"'
alias update='yaourt -Syua --noconfirm --ignore java-testng --ignore javahelp2 --ignore jgraphx --ignore scilab --ignore firefox-always-nightly --ignore postgresql --ignore postgresql-libs'

alias l='ls'
alias ll='ls -l'
alias lll='ls -lisha'
alias la='ls -a'
alias ga='git add'
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gcm='git commit -m'
alias gcSm='git commit -S -m'
alias gr='git rm'
alias gco='git checkout'
alias gl="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias gps='git push'
alias gpl='git pull'
alias s='sudo systemctl'
alias log='sudo journalctl -u'
alias logf='sudo journalctl -fu'

## Additional scripts (eg completion)
for f in ~/.local/share/bash/*; do source $f; done

# ROS
if [[ -f /opt/ros/kinetic/setup.bash ]]; then
	source /opt/ros/kinetic/setup.bash
	source ~/catkin_ws/devel/setup.bash
fi

# Prompt
function parse_git_dirty {
 [[ $(git status 2> /dev/null | tail -n1) != "rien à valider, la copie de travail est propre" ]] && echo "*"
}
function parse_git_branch {
 git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\(\1$(parse_git_dirty)\)/"
}

COLOR_NONE='\[\e[00m\]'
COLOR_LCYAN='\[\e[01;36m\]'
COLOR_LYELLOW='\[\e[01;33m\]'
COLOR_LMAGENTA='\[\e[01;35m\]'
COLOR_LGRAY='\[\e[01;37m\]'

PS1="${COLOR_LGRAY}[\t] ${COLOR_LCYAN}\u@\H${COLOR_NONE}:${COLOR_LMAGENTA}\w${COLOR_NONE} ${COLOR_LYELLOW}\$(parse_git_branch)${COLOR_NONE}$ "

# Tilix VTE stuff
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi

eval "$(direnv hook bash)"
