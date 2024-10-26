#!/bin/sh

target_process="wlsunset"

if pgrep "$target_process" >/dev/null; then
	echo '{ "text":"󱩌", "tooltip": "night-mode <span color=\"#a6da95\">on</span>", "class": "on" }'
else
	echo '{ "text":"󱩍", "tooltip": "night-mode <span color=\"#ee99a0\">off</span>", "class": "off" }'
fi