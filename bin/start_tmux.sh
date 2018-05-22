#!/bin/bash

# the name of your primary tmux session
SESSION=$1

# if the session is already running, just attach to it.
tmux attach -t $SESSION && exit
tmux new-session -d -s $SESSION
tmux split-window -h -l 90 -t $SESSION:0
tmux select-pane -t $SESSION:0.top-left
tmux split-window -v -t $SESSION:0

# Now populate the session with the windows you use every day
#tmux set-window-option -t $SESSION -g automatic-rename off
#tmux new-window        -t $SESSION:0 -k -n irc weechat-curses
#tmux set-window-option -t $SESSION:0 automatic-rename off

# this didn't seem to work. test more or just use weechat beep.pl script
#tmux set-window-option -t $SESSION:0 monitor-content $IRC_NICK
# keep window open and use respawn-window to restart
#tmux set-window-option -t $SESSION:0 remain-on-exit on

#tmux rename-window -t $SESSION:0 -n irc
#tmux new-window    -t $SESSION:1 -n mail alpine
# So that I can quickly hit ^b2<spacebar> to pause my tunes, I always put music in window 2.
# Makefile target does this: mpg123 --shuffle --control --list *m3u
#tmux new-window -t $SESSION:2 -n music 'cd ~/Music; make music'

#tmux new-window    -t $SESSION:2 -n temp # just to leave 2 empty

# After those base windows are statically defined, what follows depends where
# I'm working and what my focus is.
# So these new windows will just  number sequentially.
# You might prefer to use send-keys rather than execute ssh immediately...
#tmux new-window    -t $SESSION -a -n back  'ssh root@bacula'
#tmux kill-window   -t $SESSION:2 # just want to leave slot 2 empty 

# all done. select starting window and get to work
# you may need to cycle through windows and type in passwords
# if you don't use ssh keys
#tmux select-window -t $SESSION:0
tmux attach -t $SESSION
