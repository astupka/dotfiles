## This file is sourced by all *interactive* bash shells on startup.  This
## file *should generate no output* or it will break the scp and rcp commands.
############################################################

if [ -e /etc/bashrc ] ; then
  . /etc/bashrc
fi

############################################################
## PATH
############################################################

if [ -d ~/bin ] ; then
  PATH="~/bin:${PATH}"
fi

if [ -d ~/bin/private ] ; then
  PATH="~/bin/private:${PATH}"
fi

if [ -d /usr/local/bin ] ; then
  PATH="/usr/local/bin:${PATH}"
fi

# Node Package Manager
if [ -d /usr/local/share/npm/bin ] ; then
  PATH="${PATH}:/usr/local/share/npm/bin"
fi

# MacPorts
if [ -d /opt/local/bin ] ; then
  PATH="/opt/local/bin:${PATH}"
fi
if [ -d /opt/local/sbin ] ; then
  PATH="/opt/local/sbin:${PATH}"
fi

# MySql
if [ -d /usr/local/mysql/bin ] ; then
  PATH="${PATH}:/usr/local/mysql/bin"
fi

# PostgreSQL
if [ -d /opt/local/lib/postgresql83/bin ] ; then
  PATH="${PATH}:/opt/local/lib/postgresql83/bin"
fi

# Subversion
# if [ -d /opt/subversion/bin ] ; then
#   PATH="/opt/subversion/bin:${PATH}"
# fi

# MacTex
if [ -d /usr/texbin ] ; then
  PATH="/usr/texbin:${PATH}"
fi

PATH=.:${PATH}

############################################################
## MANPATH
############################################################

if [ -d /usr/local/man ] ; then
  MANPATH="/usr/local/man:${MANPATH}"
fi

# MacPorts
if [ -d /opt/local/share/man ] ; then
  MANPATH="/opt/local/share/man:${MANPATH}"
fi

# Set MANPATH so it includes users' private man if it exists
# if [ -d ~/man ]; then
#   MANPATH="~/man:${MANPATH}"
# fi

############################################################
## Other paths
############################################################

if [ -d ~/work ] ; then
  CDPATH=".:~/work:${CDPATH}"
fi

# Set INFOPATH so it includes users' private info if it exists
# if [ -d ~/info ]; then
#   INFOPATH="~/info:${INFOPATH}"
# fi

# DYLD_LIBRARY_PATH
# if [[ `uname` == 'Darwin' ]]; then
#   if [ -d /opt/local/lib ] ; then
#     DYLD_LIBRARY_PATH="/opt/local/lib:${DYLD_LIBRARY_PATH}"
#   fi
#   if [ -d /opt/subversion/lib ] ; then
#     DYLD_LIBRARY_PATH="/opt/subversion/lib:${DYLD_LIBRARY_PATH}"
#   fi
# fi

############################################################
## Terminal behavior
############################################################

# Change the window title of X terminals
case $TERM in
  xterm*|rxvt|Eterm|eterm)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
    ;;
  screen)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
    ;;
esac
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Show the git branch and dirty state in the prompt.
# Borrowed from: http://henrik.nyh.se/2008/12/git-dirty-prompt
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\(\1$(parse_git_dirty)\)/"
}

# Do not set PS1 for dumb terminals
if [ "$TERM" != 'dumb'  ] && [ -n "$BASH" ]
then
  export PS1='\[\033[32m\]\n[\s: \w] $(parse_git_branch)\n\[\033[31m\][\u@\h]\$ \[\033[00m\]'
fi

############################################################
## Optional shell behavior
############################################################

shopt -s cdspell
shopt -s extglob
shopt -s checkwinsize

export PAGER="less"
export EDITOR="vi"

############################################################
## History
############################################################

# When you exit a shell, the history from that session is appended to
# ~/.bash_history.  Without this, you might very well lose the history of entire
# sessions (weird that this is not enabled by default).
shopt -s histappend

export HISTIGNORE="&:pwd:ls:ll:lal:[bf]g:exit:rm*:sudo rm*"
# remove duplicates from the history (when a new item is added)
export HISTCONTROL=ignoredups:erasedups
# increase the default size from only 1,000 items
export HISTSIZE=100000
export HISTFILESIZE=100000

############################################################
## Aliases
############################################################

if [ -e ~/.bash_aliases ] ; then
  . ~/.bash_aliases
fi

############################################################
## Bash Completion, if available
############################################################

if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
elif  [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
elif  [ -f /etc/profile.d/bash_completion ]; then
  . /etc/profile.d/bash_completion
fi

# http://onrails.org/articles/2006/11/17/rake-command-completion-using-rake
if [ -f ~/bin/rake_completion ]; then
  complete -C ~/bin/rake_completion -o default rake
fi

if [ -f ~/bin/git_completion ]; then
  . ~/bin/git_completion
fi
############################################################
## AutoJump
############################################################
#_autojump()
#{
#        local cur
#        cur=${COMP_WORDS[*]:1}
#        while read i
#        do
#            COMPREPLY=("${COMPREPLY[@]}" "${i}")
#        done  < <(autojump --bash --completion $cur)
#}
#complete -F _autojump j
#data_dir=${XDG_DATA_HOME:-$([ -e ~/.local/share ] && echo ~/.local/share || echo ~)}
#if [ "$data_dir" = "~" ]
#then
#    export AUTOJUMP_DATA_DIR=${data_dir}
#else
#    export AUTOJUMP_DATA_DIR=${data_dir}/autojump
#fi
#if [ ! -e "${AUTOJUMP_DATA_DIR}" ]
#then
#    mkdir "${AUTOJUMP_DATA_DIR}"
#    mv ~/.autojump_py "${AUTOJUMP_DATA_DIR}/autojump_py" 2>>/dev/null #migration
#    mv ~/.autojump_py.bak "${AUTOJUMP_DATA_DIR}/autojump_py.bak" 2>>/dev/null
#    mv ~/.autojump_errors "${AUTOJUMP_DATA_DIR}/autojump_errors" 2>>/dev/null
#fi
#
#AUTOJUMP='{ (autojump -a "$(pwd -P)"&)>/dev/null 2>>${AUTOJUMP_DATA_DIR}/.autojump_errors;} 2>/dev/null'
#if [[ ! $PROMPT_COMMAND =~ autojump ]]; then
#  export PROMPT_COMMAND="${PROMPT_COMMAND:-:} && $AUTOJUMP"
#fi
#alias jumpstat="autojump --stat"
#function j { new_path="$(autojump $@)";if [ -n "$new_path" ]; then echo -e "\\033[31m${new_path}\\033[0m"; cd "$new_path";fi }
############################################################
## Other
############################################################

#source /usr/local/etc/bash_completion.d/cdargs-bash.sh

if [[ "$USER" == '' ]]; then
  # mainly for cygwin terminals. set USER env var if not already set
  USER=$USERNAME
fi

# MacPorts OpenSSL doesn't have a ca bundle, so piggy back on Curl's
if [ -f /opt/local/share/curl/curl-ca-bundle.crt ] ; then
  export SSL_CERT_FILE="/opt/local/share/curl/curl-ca-bundle.crt"
fi

function build_tags() {
  rm -f cscope.files tags cscope.out
  find . "$GEM_HOME" -name '*.rb' >cscope.files
  xargs -n100 ctags -a < cscope.files
  cscope -P$(pwd) -b
}

############################################################

# VI Mode

set -o vi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[ -f /Users/astupka/working/projects/customink/printron/node_modules/tabtab/.completions/electron-forge.bash ] && . /Users/astupka/working/projects/customink/printron/node_modules/tabtab/.completions/electron-forge.bash