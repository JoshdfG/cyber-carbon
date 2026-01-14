#!/opt/homebrew/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_PATH="$CURRENT_DIR/src"

source "$SCRIPTS_PATH/themes.sh" || {
	echo "Error: Failed to source themes.sh" >&2
	exit 1
}

tmux set -g status-left-length 80
tmux set -g status-right-length 150
tmux set -g mode-style "fg=${THEME[black]},bg=${THEME[yellow_bright]},bold"

tmux set -g message-style "bg=${THEME[bblue]},fg=${THEME[background]},bold"
tmux set -g message-command-style "fg=${THEME[white]},bg=${THEME[black]},bold"

tmux set -g pane-border-style "fg=${THEME[bblack]}"
tmux set -g pane-active-border-style "fg=${THEME[white]},bold"
tmux set -g pane-border-status off

tmux set -g status-style "fg=${THEME[foreground]},bg=${THEME[background]}"

window_id_style="$(tmux show-option -gv @cyber-carbon_window_id_style 2>/dev/null || echo "medium")"
terminal_icon="$(tmux show-option -gv @cyber-carbon_terminal_icon 2>/dev/null || echo '')"
active_terminal_icon="$(tmux show-option -gv @cyber-carbon_active_terminal_icon 2>/dev/null || echo '')"

git_status="#($SCRIPTS_PATH/git-status.sh #{pane_current_path})"
wb_git_status="#($SCRIPTS_PATH/wb-git-status.sh #{pane_current_path} &)"
date_and_time="$($SCRIPTS_PATH/datetime-widget.sh)"
battery_status="#($SCRIPTS_PATH/battery-widget.sh)"

tmux set -g status-left "\
#[fg=${THEME[black]},bg=${THEME[blue]},bold] \
#{?client_prefix,󰠠 ,󰤂 }\
#[bold,nodim]#S "

tmux set -g window-status-current-format "\
$RESET#[fg=${THEME[bpurple]},bold]\
#($SCRIPTS_PATH/custom-number.sh #I $window_id_style)\
#[fg=${THEME[bpurple]},bg=${THEME[bblack]}] \
#{?#{==:#{pane_current_command},ssh},󰣀 ,$active_terminal_icon }#W\
#[nobold,dim]\
#{?window_zoomed_flag,"

tmux set -g window-status-format "\
$RESET#[fg=${THEME[foreground]}]\
#($SCRIPTS_PATH/custom-number.sh #I $window_id_style)\
#[fg=${THEME[foreground]}] \
#{?#{==:#{pane_current_command},ssh},󰣀 ,$terminal_icon }#W\
#[nobold,dim]\
#{?window_zoomed_flag,"

right_status="\
$git_status \
#[fg=${THEME[ghpurple]},bg=${THEME[black]}]$wb_git_status \
#[fg=${THEME[ghred]},bg=${THEME[background]}]$battery_status \
#[fg=${THEME[ghyellow]},bg=${THEME[black]}]$date_and_time"

tmux set -g status-right "$right_status"

tmux set -g window-status-separator "|"
