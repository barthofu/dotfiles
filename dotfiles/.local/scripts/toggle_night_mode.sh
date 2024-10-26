#!/bin/sh

if pgrep wlsunset >/dev/null; then
	killall wlsunset
else
	wlsunset -t 4000 &
fi