# Tmux `hh` and `flow` status

A simple indicator for checking if you have hack errors.

Inspired by [tmux-battery](https://github.com/tmux-plugins/tmux-battery)

Tested and working on Linux, and the latest versions of Hack and Flow.

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'jra3/tmux-code-server-status'

Hit `prefix + I` to fetch the plugin and source it. You should now be able to
use the plugin.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/jra3/tmux-code-server-status ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell "~/clone/path/tmux-code-server-status/tmux-code-server-status.tmux"

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

You should now be able to use the plugin.

### Configuring the status bar

You now need to specify how to show your status indicator in your
status bar. You may add any of the interpolation tokens from the
package into either the status-left or status-right strings in tmux.
This is a highly personal decision, but I simply put mine at the very
left of the bar.

    set -g status-left 'H:#{hh_status_icon}F:#{flow_status_icon}'

### License

[MIT](LICENSE.md)
