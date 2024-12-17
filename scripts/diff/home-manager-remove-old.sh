##!/bin/bash

# Fetch the current Home Manager generation ID
current_gen=$(home-manager switch --flake .#thinkpad --impure | grep 'latest profile generation' | awk '{print $NF}')

# Check if we were able to get the current generation
if [[ -n "$current_gen" ]]; then
	echo "Current Home Manager Generation ID: $current_gen"

	# Loop through all generations and remove non-current ones
	for gen in $(home-manager generations | awk -F 'id ' '{print $2}' | awk '{print $1}'); do
		if [ "$gen" -ne "$current_gen" ]; then
			echo "Removing generation: $gen"
			home-manager remove-generations "$gen"
		fi
	done

	echo "Old generations removed."

else
	echo "Failed to determine the current generation ID."
fi
