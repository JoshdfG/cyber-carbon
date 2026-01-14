#!/opt/homebrew/bin/bash

declare -A FORMATS=(
	["hide"]=""
	["arabic"]="0123456789"
	["medium"]="𝟎𝟏𝟐𝟑𝟒𝟓𝟔𝟕𝟖𝟗"
	["thin"]="𝟶𝟷𝟸𝟹𝟺𝟻𝟼𝟽𝟾𝟿"
	["fsquare"]="󰎡󰎤󰎧󰎪󰎭󰎱󰎳󰎶󰎹󰎼"
	["hsquare"]="󰎣󰎦󰎩󰎬󰎮󰎰󰎵󰎸󰎻󰎾"
	["dsquare"]="󰎢󰎥󰎨󰎫󰎲󰎯󰎴󰎷󰎺󰎽"
	["super"]="⁰¹²³⁴⁵⁶⁷⁸⁹"
	["sub"]="₀₁₂₃₄₅₆₇₈₉"
	["earabic"]="٠١٢٣٤٥٦٧٨٩"
	["digital"]="🯰🯱🯲🯳🯴🯵🯶🯷🯸🯹"
)

ID="$1"
FORMAT="${2:-none}"

# Fallback to arabic if style not found
[[ -z "${FORMATS[$FORMAT]}" ]] && FORMAT="arabic"

format_str="${FORMATS[$FORMAT]}"
result=""

# If ID is not a number, just return the ID
if [[ ! $ID =~ ^[0-9]+$ ]]; then
	echo -n "$ID"
	exit 0
fi

for ((i = 0; i < ${#ID}; i++)); do
	digit="${ID:$i:1}"
	char="${format_str:$digit:1}"
	result+="${char}"
done

echo -n "$result"
