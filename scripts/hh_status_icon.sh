#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

# script global variables
clean_icon=""
waiting_icon=""
error_icon=""

# These emoji seem to work over my mosh and in my tmux, unlike most
clean_default="\u270C\uFE0F"
waiting_default="\u231B\uFE0F"
error_default="\u2620\uFE0F"

# icons are set as script global variables
get_icon_settings() {
    clean_icon=$(get_tmux_option "@hh_status_clean_icon" "$clean_default")
    waiting_icon=$(get_tmux_option "@hh_status_waiting_icon" "$waiting_default")
    error_icon=$(get_tmux_option "@hh_status_error_icon" "$error_default")
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
    local status=$(hh_status)
    print_icon $status
}
main
