#!/bin/bash
# Log all arguments and tmux variables
echo "========== $(date) ==========" >> /tmp/tmux-debug.log
echo "All args: $@" >> /tmp/tmux-debug.log
echo "Arg1 (ID): '$1'" >> /tmp/tmux-debug.log
echo "Arg2 (FORMAT): '$2'" >> /tmp/tmux-debug.log
echo "Arg3 (EXTRA): '$3'" >> /tmp/tmux-debug.log
echo "PANE_INDEX: '$PANE_INDEX'" >> /tmp/tmux-debug.log
echo "PANE_ID: '$PANE_ID'" >> /tmp/tmux-debug.log
# Echo back the first arg so tmux shows something
echo -n "[$1]"
