#!/usr/bin/env bash

dir="$HOME/.config/polybar"

launch_bar() {
	# Terminate already running bar instances
	kill -9 $(pgrep -f 'polybar') >/dev/null 2>&1 & echo ''

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

	# Launch the bar
    polybar -q main -c "$dir/$style/config.ini" &	
}

if [[ "$1" == "--ghost" ]]; then
	style="ghost"
	launch_bar
else
	cat <<- EOF
	Usage : launch.sh --<theme>
		
	Available Themes :
	--ghost
	EOF
fi
