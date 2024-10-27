#!/bin/sh

postal_code=${1:-69003}

alacritty --class meteo -t "Meteo" -e bash -c "curl wttr.in/${postal_code}; sleep infinity"