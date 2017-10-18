#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPTS_DIR="$CURRENT_DIR/scripts"

source "$SCRIPTS_DIR/helpers.sh"

# TODO: add flow
code_server_interpolation=(
    "\#{hh_status_icon}"
    "\#{flow_status_icon}"
)

code_server_commands=(
    "#($CURRENT_DIR/scripts/hh_status_icon.sh)"
    "#($CURRENT_DIR/scripts/flow_status_icon.sh)"
)

set_tmux_option() {
    local option="$1"
    local value="$2"
    tmux set-option -gq "$option" "$value"
}

do_interpolation() {
    local all_interpolated="$1"
    for ((i=0; i<${#code_server_commands[@]}; i++)); do
        all_interpolated=${all_interpolated/${code_server_interpolation[$i]}/${code_server_commands[$i]}}
    done
    echo "$all_interpolated"
}

update_tmux_option() {
    local option="$1"
    local option_value="$(get_tmux_option "$option")"
    local new_option_value="$(do_interpolation "$option_value")"
    set_tmux_option "$option" "$new_option_value"
}

main() {
    update_tmux_option "status-right"
    update_tmux_option "status-left"
}
main
