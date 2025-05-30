#!/bin/bash

# Set DISPLAY variable for GUI applications
#export DISPLAY=:0

while true; do
    # Wait until the "PayloadCamera" window appears
    while ! wmctrl -l | grep -q "PayloadCamera"; do
        sleep 1  # Check every second
    done

    # Once the window appears, make it fullscreen
    wmctrl -r "PayloadCamera" -b add,fullscreen

    # Wait until the window disappears before restarting the loop
    while wmctrl -l | grep -q "PayloadCamera"; do
        sleep 1  # Check every second if it is still open
    done
done

