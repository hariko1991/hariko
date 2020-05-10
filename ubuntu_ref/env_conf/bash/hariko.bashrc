# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='${debian_chroot:+($debian_chroot)}\[\e[32;1m\][\[\e[31;1m\]\u\[\e[33;1m\]@\[\e[31;1m\]\h \[\e[36;1m\]\w\[\e[32;1m\]]\[\e[35;1m\]\$ \[\e[0m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias hariko='cd ~'
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
export REDIS_HOME=/usr/app/redis-5.0.8
export ROCKET_MQ_HOME=/usr/app/rocketmq/rocketmq-4.7.0
export ROCKETMQ_HOME=/usr/app/rocketmq/rocketmq-4.7.0
export ROCKET_MQ_A=/usr/app/rocketmq/rocketmq-a/
export ROCKET_MQ_B=/usr/app/rocketmq/rocketmq-b/

export PATH=$REDIS_HOME/bin:$ROCKET_MQ_HOME/bin:$PATH

srm(){
  case "$1" in
       1)
       mqnamesrv -c /usr/app/rocketmq/rocketmq-$2/conf/hariko/namesrv.properties &
       ;;
       2)
       mqbroker -c /usr/app/rocketmq/rocketmq-$2/conf/hariko/broker-$2.properties &
       ;;
       3)
       mqbroker -c /usr/app/rocketmq/rocketmq-$2/conf/hariko/broker-$3-s.properties &
       ;;
       4)
       mqshutdown broker;mqshutdown namesrv;
       ;;
   esac
}

alias lcredis='redis-cli -h 192.168.0.161 -p 7021 -c -a hariko'
alias lredis='redis-cli -h 192.168.0.161 -p 7027 -a hariko'
alias lsentinel='redis-cli -h 192.168.0.161 -p 27027 -a hariko'
alias snacos='bash -f ${NACOS_HOME}/bin/startup.sh -m standalone'
alias ssentinel='java -Dserver.port=8080 -Dcsp.sentinel.dashboard.server=localhost:8080 -Dproject.name=sentinel-dashboard -jar /usr/app/plugin/sentinel-dashboard-1.7.2.jar'
alias smycat='mysql -umycat -phariko -h192.168.0.161 -P8066 --default-auth=mysql_native_password'

lmysql(){
   case "$1" in
       1)
       mysql -umycat -phariko -h192.168.0.161 -P$2 --default-auth=mysql_native_password
       ;;
       2)
       mysql -uroot -phariko -h192.168.0.161 -P$2
       ;;
   esac
}

llredis(){
   redis-cli -h 192.168.0.161 -p 702$1 -a hariko;
}

sredis(){
   cd ${REDIS_HOME}/cluster/;
   redis-server redis_702$1.conf;
}

kredis(){
   redis-cli -c -p 702$1 -a hariko redis_shutdown
}

ssredis(){
   cd ${REDIS_HOME}/cluster/;
   redis-sentinel redis_sentinel_2702$1.conf;
}

szk(){
   cd /usr/app/zookeeper_cluster_3.5.6/apache-zookeeper-$1/bin/;
   ./zkServer.sh $2;
}

sczk(){
   cd /usr/app/apache-zookeeper-3.5.6/bin/;
   ./zkServer.sh $1;
}

ZOOKEEPER_HOME=/usr/app/apache-zookeeper-3.6.0
KAFKA_HOME=/usr/app/kafka_2.12-2.3.1
GRADLE_HOME=/usr/app/gradle-6.3
MVN_HOME=/usr/app/apache-maven-3.6.3
PYTHON_HOME=/usr/app/python-3.8.0
ELASTIC_SEARCH_HOME=/usr/app/elk/elasticsearch-7.6.2
KIBANA_HOME=/usr/app/elk/kibana-7.6.2
MYSQL_HOME=/usr/local/mysql
JMETER_HOME=/usr/app/apache-jmeter-5.2.1
NACOS_HOME=/usr/app/nacos-server-1.2.1
MYCAT_HOME=/usr/app/mycat-1.6
NGINX_HOME=/usr/app/nginx-1.17.9
KEEPALIVED_HOME=/usr/app/keepalived-2.0.20

alias postman='/usr/app/postman-7.23.0/app/Postman &'
alias eclipse='/usr/app/eclipse/jee-2020-03/eclipse/eclipse &'
alias nginx='/usr/app/nginx-1.18.0/sbin/nginx'

export ZOOKEEPER_HOME KAFKA_HOME GRADLE_HOME MVN_HOME PYTHON_HOME
export NACOS_HOME
export PATH=$PYTHON_HOME/bin:$ZOOKEEPER_HOME/bin:$KAFKA_HOME/bin:$PATH
export PATH=$GRADLE_HOME/bin:$MVN_HOME/bin:$PATH
export PATH=$JAVA_HOME/bin:$ELASTIC_SEARCH_HOME/bin:$KIBANA_HOME/bin:$PATH
export PATH=$MYSQL_HOME/bin:$PATH
export PATH=$JMETER_HOME/bin:$PATH
export PATH=$NACOS_HOME/bin:$PATH
export PATH=$MYCAT_HOME/bin:$PATH
export PATH=$NGINX_HOME/sbin:$PATH
export PATH=$KEEPALIVED_HOME/sbin:$KEEPALIVED_HOME/bin:$PATH

skaf(){
   case "$1" in
     start)
       ${KAFKA_HOME}/bin/kafka-server-start.sh -daemon ${KAFKA_HOME}/config/server.properties
       ;;
     stop)
       ${KAFKA_HOME}/bin/kafka-server-stop.sh
       ;;
   esac
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/app/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/app/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/app/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/app/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

