#!/bin/sh
# Force wlsunset into a permanent "night" state (sunset just after sunrise)
# so the toggle applies the warm temperature immediately, instead of only
# during a real dusk/dawn schedule.

if pgrep wlsunset >/dev/null; then
	killall wlsunset
else
	wlsunset -t 4500 -T 6500 -S 00:00 -s 00:01 &
fi