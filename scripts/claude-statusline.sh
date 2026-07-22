#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
SESSION_COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')

USED=$(echo "$input" | jq -r '((.context_window.total_input_tokens // 0) + (.context_window.total_output_tokens // 0))')
MAX=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

BRANCH=""
if git -C "$DIR" rev-parse --git-dir >/dev/null 2>&1; then
  BRANCH=$(git -C "$DIR" branch --show-current 2>/dev/null)
fi

fmt_tokens() {
  awk -v n="$1" 'BEGIN {
    if (n >= 1000000) { v = n / 1000000; suf = "M" }
    else if (n >= 1000) { v = n / 1000; suf = "K" }
    else { printf "%d", n; exit }
    if (v == int(v)) printf "%d%s", v, suf
    else printf "%.1f%s", v, suf
  }'
}

USED_FMT=$(fmt_tokens "$USED")
MAX_FMT=$(fmt_tokens "$MAX")

CYAN='\033[36m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
MAGENTA='\033[35m'
RESET='\033[0m'

if [ "$PCT" -ge 90 ]; then
  PCT_COLOR="$RED"
elif [ "$PCT" -ge 70 ]; then
  PCT_COLOR="$YELLOW"
else PCT_COLOR="$GREEN"; fi

SESSION_COST_FMT=$(awk -v c="$SESSION_COST" 'BEGIN{printf "%.2f", c}')

OUT="${CYAN}[$MODEL]${RESET} 📁 ${DIR##*/}"
[ -n "$BRANCH" ] && OUT="$OUT | 🌿 $BRANCH"
OUT="$OUT | ${PCT_COLOR}${USED_FMT}/${MAX_FMT} (${PCT}%)${RESET}"
OUT="$OUT | ${MAGENTA}\$${SESSION_COST_FMT} ${RESET}"

echo -e "$OUT"
