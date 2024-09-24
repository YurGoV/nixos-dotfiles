###!/bin/bash

# Get fan speed using sensors
FAN_SPEED=$(sensors | grep 'fan1' | awk '{print $2}')
if [[ "$FAN_SPEED" -eq 0 ]]; then
	FORMATTED_SPEED="0"
else

	INTEGER_PART=$((FAN_SPEED / 1000))
	DECIMAL_PART=$((FAN_SPEED % 1000))
	FORMATTED_SPEED="${INTEGER_PART},${DECIMAL_PART}"
fi

if [ "$FAN_SPEED" -gt 0 ]; then
	CLASS="fan-speed-run"
else
	CLASS="fan-speed-idle"
fi

echo "{\"text\":\"$FORMATTED_SPEED ❋\", \"class\":\"$CLASS\"}"
