get_tmux_option() {
  local option=$1
  local default_value=$2
  local option_value=$(tmux show-option -gqv "$option")
  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

command_exists() {
  local command="$1"
  type "$command" >/dev/null 2>&1
}


get_hh_status_repo() {
    hh_status_repo=$(get_tmux_option "@hh_status_repo" "$HOME/www")
}

get_flow_status_repo() {
    flow_status_repo=$(get_tmux_option "@flow_status_repo" "$HOME/www")
}

hh_status() {
    get_hh_status_repo
    hh_client check --autostart-server true --no-load --from tmux --retries 0 --timeout 0.5 "$hh_status_repo" > /dev/null 2>&1
    RETURN="$?"

    case "$RETURN" in
        0)
            echo clean
            ;;
        7)
            echo waiting
            ;;
        *)
            echo error
            ;;
    esac
}

flow_status() {
    get_flow_status_repo
    flow --from tmux --retries 0 --retry-if-init false --timeout 1 "$flow_status_repo" > /dev/null 2>&1
    RETURN="$?"

    case "$RETURN" in
        0)
            echo clean
            ;;
        3)
            echo waiting
            ;;
        *)
            echo error
            ;;
    esac
}
