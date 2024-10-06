# Path to the sound file
SOUND_FILE="/home/yurgo/.dotfiles/assets/sounds/warning-sound-6686.mp3"
# Temporary file to track if sound has been played
SOUND_PLAYED_FILE="/dev/shm/sound_played"

# Get the current temperature
# FAN_SPEED=$(sensors | grep 'fan1' | awk '{print $2}')
# CURRENT_TEMP=$(sensors | grep 'CPU' | awk '{print $2}' | tr -d '+°C')

# Get the current temperature as a digit
# CURRENT_TEMP=$(sensors | grep 'CPU' | grep -o '[0-9]\+')
CURRENT_TEMP=$(sensors | grep 'CPU' | grep -o '[0-9]\+' | tr -d '\n')
# CURRENT_TEMP=$(sensors | grep 'CPU' | grep -o '[0-9]\+' | tr -d '\n')
# Convert to Celsius (divide by 1000)
CURRENT_TEMP_C=$((CURRENT_TEMP / 10))

echo "$CURRENT_TEMP_C";
echo "$SOUND_PLAYED_FILE"
# rm "$SOUND_PLAYED_FILE"
# Check if the temperature exceeds the critical threshold
if [ "$CURRENT_TEMP_C" -gt 75 ]; then
	# Check if sound has not been played yet
	if [ ! -f "$SOUND_PLAYED_FILE" ]; then
		# Play the sound using VLC
		cvlc --play-and-exit "$SOUND_FILE" &
		# Create the temporary file to indicate sound has been played
		touch "$SOUND_PLAYED_FILE" &
	fi
else
	# If temperature is below threshold, remove the flag file
	if [ -f "$SOUND_PLAYED_FILE" ]; then
    echo "run remove sp lock file"
		rm "$SOUND_PLAYED_FILE"
	fi
fi
