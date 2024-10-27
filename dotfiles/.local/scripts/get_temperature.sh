#!/bin/sh

critical_temp=95

# Average calculation upon multiple components is currently disabled
# because it takes too long to execute and is not very useful

# Get specific component temperatures
cpu_temp=$(sensors | awk '/Core 0/ {print $3}' | tr -d '+°C' | awk '{print int($1+0.5)}')

# gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)
# motherboard_temp=$(sensors | awk '/temp1/ {print $2}' | head -1 | tr -d '+°C')

# Calculate weighted average
# weighted_temp=$(echo "($cpu_temp * 0.6) + ($gpu_temp * 0.3) + ($motherboard_temp * 0.1)" | bc -l)
weighted_temp=$cpu_temp

icon=""
if [ "$weighted_temp" -ge 80 ]; then
    icon=""
elif [ "$weighted_temp" -ge 60 ]; then
    icon=""
fi

class="normal"
if [ "$weighted_temp" -ge "$critical_temp" ]; then
    class="critical"
elif [ "$weighted_temp" -ge 80 ]; then
    class="hot"
elif [ "$weighted_temp" -ge 60 ]; then
    class="warm"
fi

echo "{ \"text\":\"$icon $weighted_temp°C\", \"class\": \"$class\" }"
