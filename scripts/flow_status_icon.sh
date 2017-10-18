#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

# script global variables
clean_icon=""
waiting_icon=""
error_icon=""

# TODO emoji
clean_default="✔"
waiting_default="…"
error_default="✖"

# icons are set as script global variables
get_icon_settings() {
    clean_icon=$(get_tmux_option "@flow_status_clean_icon" "$clean_default")
    waiting_icon=$(get_tmux_option "@flow_status_waiting_icon" "$waiting_default")
    error_icon=$(get_tmux_option "@flow_status_error_icon" "$error_default")
}

print_icon() {
    local status=$1
    if [[ $status == clean ]]; then
        printf "$clean_icon"
    elif [[ $status == waiting ]]; then
        printf "$waiting_icon"
    else
        printf "$error_icon"
    fi
}

main() {
    get_icon_settings
    local status=$(flow_status)
    print_icon $status
}
main
