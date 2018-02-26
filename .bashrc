eval "$(direnv hook bash)"
source /etc/bash.bashrc

export GOPATH="/home/brendan/go"
export EDITOR="vim"

# Path

export PATH="$PATH:/usr/local/bin/matlab"
export PATH="/usr/sbin:/sbin:/bin:/usr/games:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.bin:$PATH"
export PATH="/home/brendan/.gem/ruby/2.4.0/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$PATH:/bin"

# Shortcuts

alias matlab="/usr/local/bin/matlab/matlab"
alias spaces2tab='grep -Er "*+" --exclude-dir={.git,node_modules,vendor} --exclude="*.yml" --exclude="*.md" --exclude=".gitignore" | grep ":" | cut -d":" -f1 | sort -u | xargs sed -Ei "s/^    /\t/"'
alias vpn='sudo openvpn --config ~/Documents/ccrypto-nl-tcp.ovpn.ovpn'
alias pitivi='optirun flatpak run org.pitivi.Pitivi//stable'
alias ffupdate='pacaur -S --noconfirm --noedit firefox-always-nightly'
alias update='yaourt -Syua --noconfirm --ignore java-testng --ignore javahelp2 --ignore jgraphx --ignore scilab --ignore firefox-always-nightly --ignore postgresql --ignore postgresql-libs'
alias backuphome='rsync --links --recursive --progress --exclude=".cache" $HOME/*'
alias new-gb-project='mkdir src vendor bin pkg && git init && echo -e "bin\npkg" > .gitignore'
alias gocode-lookup='gocode set package-lookup-mode'

alias l='ls'
alias ll='ls -l'
alias lll='ls -lisha'
alias la='ls -a'
alias ga='git add'
alias gs='git status'
alias gd='git status'
alias gc='git commit'
alias gr='git rm'
alias gco='git checkout'
alias gl="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias s='sudo systemctl'
alias log='sudo journalctl -u'
alias logf='sudo journalctl -fu'

#source /usr/share/nvm/init-nvm.sh
alias nv7="nvm use --delete-prefix v7.10"

# Matrix

alias goneb="cd ~/Documents/matrix/go-neb && BIND_ADDRESS=:4050 BASE_URL=http://localhost:4050 DATABASE_TYPE=sqlite3 DATABASE_URL=go-neb.db?_busy_timeout=5000 bin/go-neb"

## Dendrite

alias kafstart="/home/brendan/Documents/matrix/dendrite/kafka/bin/kafka-server-start.sh -daemon /home/brendan/Documents/matrix/dendrite/kafka/config/server.properties"
alias denproxy='./bin/client-api-proxy \
--bind-address ":8448" \
--sync-api-server-url "http://localhost:7773" \
--client-api-server-url "http://localhost:7771" \
--media-api-server-url "http://localhost:7774" \
--public-rooms-api-server-url "http://localhost:7775" \
--tls-cert _test/federation_cert.pem \
--tls-key _test/federation_key.pem'
alias denmono='./bin/dendrite-monolith-server \
 --tls-cert "_test/federation_cert.pem" \
 --tls-key "_test/federation_key.pem"'

## Additional scripts (eg completion)
for f in ~/.local/share/bash/*; do source $f; done

# ROS
if [[ -f /opt/ros/kinetic/setup.bash ]]; then
	source /opt/ros/kinetic/setup.bash
	source ~/catkin_ws/devel/setup.bash
fi

# Prompt
function parse_git_dirty {
 [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
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
