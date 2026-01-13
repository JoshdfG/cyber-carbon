#!/usr/bin/env bash

SELECTED_THEME="$(tmux show-option -gv @gruvbox-tmux_theme 2>/dev/null || echo "hard")"
TRANSPARENT_THEME="$(tmux show-option -gv @gruvbox-tmux_transparent 2>/dev/null || echo 0)"

declare -A THEMES=(
	# light (Clean Paper)
	[light_background]="#f2f4f8" # Crisp paper
	[light_foreground]="#2e3440" # Dark ink
	[light_black]="#d8dee9"      # Light grey
	[light_blue]="#5e81ac"       # Professional blue
	[light_aqua]="#3b4252"       # Dark Slate
	[light_green]="#4e7d34"      # Leaf green
	[light_purple]="#6b528b"     # Royal purple
	[light_red]="#a54242"        # Crimson
	[light_white]="#2e3440"      # Ink black
	[light_yellow]="#8f6f14"     # Ochre
	[light_bblack]="#e5e9f0"     # Soft cloud
	[light_bblue]="#81a1c1"      # Sky blue
	[light_baqua]="#88c0d0"      # Bright aqua
	[light_bgreen]="#a3be8c"     # Pale green
	[light_bpurple]="#b48ead"    # Pale purple
	[light_bred]="#bf616a"       # Pale red
	[light_bwhite]="#ffffff"     # Pure white
	[light_byellow]="#ebcb8b"    # Pale yellow

	# soft
	[soft_background]="#32302F"
	[soft_foreground]="#fbf1c7"
	[soft_black]="#32302F"
	[soft_blue]="#458588"
	[soft_aqua]="#689d6a"
	[soft_green]="#98971a"
	[soft_purple]="#b16286"
	[soft_red]="#cc241d"
	[soft_white]="#fbf1c7"
	[soft_yellow]="#d79921"
	[soft_bblack]="#3C3836"
	[soft_bblue]="#83a598"
	[soft_baqua]="#8ec07c"
	[soft_bgreen]="#b8bb26"
	[soft_bpurple]="#d3869b"
	[soft_bred]="#fb4934"
	[soft_bwhite]="#EBDBB2"
	[soft_byellow]="#fabd2f"

	# medium (Nordic Forest)
	[medium_background]="#2e3440" # Nord Blue-Grey
	[medium_foreground]="#eceff4" # Frost white
	[medium_black]="#3b4252"      # Night black
	[medium_blue]="#81a1c1"       # Glacial blue
	[medium_aqua]="#88c0d0"       # Arctic cyan
	[medium_green]="#a3be8c"      # Sage green
	[medium_purple]="#b48ead"     # Muted plum
	[medium_red]="#bf616a"        # Brick red
	[medium_white]="#d8dee9"      # Snow
	[medium_yellow]="#ebcb8b"     # Sand yellow
	[medium_bblack]="#434c5e"     # Storm grey
	[medium_bblue]="#5e81ac"      # Deep lake
	[medium_baqua]="#8fbcbb"      # Mint
	[medium_bgreen]="#d08770"     # Copper (Accent)
	[medium_bpurple]="#b48ead"    # Lavender
	[medium_bred]="#bf616a"       # Soft red
	[medium_bwhite]="#e5e9f0"     # Bright snow
	[medium_byellow]="#ebcb8b"    # Goldenrod	# hard

	# custom-carbon (Replace 'hard' values with these)
	[hard_background]="#1E1E2E" #bg color black -#0f0f14 tokyo-night: #1E1E2E
	[hard_foreground]="#cfcfff"
	[hard_black]="#0f0f14"
	[hard_blue]="#7aa2f7" #active pane bg color
	[hard_aqua]="#00ff9c"
	[hard_green]="#a6e22e"
	[hard_purple]="#b4a2ff"
	[hard_red]="#ff5189"
	[hard_white]="#cfcfff"
	[hard_yellow]="#ff9e64"
	[hard_bblack]="#1a1a24"
	[hard_yellow_bright]="#FFE073"
	# [hard_bblue]="#FFE073" # tmux command mode bg #7aa2f7
	[hard_baqua]="#89ddff"
	[hard_bgreen]="#c3e88d"
	# [hard_bpurple]="#f07178" #44FFB1
	[hard_bpurple]="#44FFB1" # active pane
	[hard_bred]="#db4b4b"
	[hard_bwhite]="#ffffff"
	[hard_byellow]="#e0af68"
)

declare -A THEME
for key in background foreground black blue aqua green purple red white yellow \
	bblack bblue baqua bgreen bpurple bred bwhite byellow; do
	color_key="${SELECTED_THEME}_${key}"
	THEME["$key"]="${THEMES[$color_key]:-${THEMES[hard_${key}]}}"
done

if [[ "${TRANSPARENT_THEME}" == "1" ]]; then
	THEME["background"]="default"
fi

# Define brand/status colors based on the theme style
if [[ "${SELECTED_THEME}" == "light" ]]; then
	THEME['ghgreen']="#4e7d34"  # Deep Leaf
	THEME['ghpurple']="#6b528b" # Royal Purple
	THEME['ghred']="#a54242"    # Crimson
	THEME['ghyellow']="#8f6f14" # Dark Ochre
	THEME['yellow_bright']="#ebcb8b"
elif [[ "${SELECTED_THEME}" == "medium" ]]; then
	THEME['ghgreen']="#a3be8c"  # Sage
	THEME['ghpurple']="#b48ead" # Plum
	THEME['ghred']="#bf616a"    # Brick
	THEME['ghyellow']="#ebcb8b" # Sand
	THEME['yellow_bright']="#ebcb8b"
else
	# Default/Hard (Cyberpunk)
	THEME['ghgreen']="#9ece6a"  # Toxic Green
	THEME['ghpurple']="#bb9af7" # Cyber Purple
	THEME['ghred']="#f7768e"    # Neon Red
	THEME['ghyellow']="#e0af68" # Sunset Orange
	THEME['yellow_bright']="#ebcb8b"
fi

RESET="#[fg=${THEME[foreground]},bg=${THEME[background]},nobold,noitalics,nounderscore,nodim]"
