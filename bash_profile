# ~/.bash_profile: executed by bash for login shells.

if [ -e ~/.bashrc ] ; then
  . ~/.bashrc
fi

# Put all local machine customizations in ~/.bash_local
if [ -e ~/.bash_local ] ; then
  . ~/.bash_local
fi


export PATH="/opt/homebrew/bin:$PATH"
eval "$(rbenv init -)"

# Created by `pipx` on 2023-08-04 04:10:14
export PATH="$PATH:/Users/alexstupka/.local/bin"
export PATH="/usr/local/opt/libpq/bin:$PATH"

eval "$(/opt/homebrew/bin/brew shellenv)"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.bash 2>/dev/null || :
