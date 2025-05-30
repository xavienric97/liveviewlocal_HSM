#!/bin/bash

# Set the DISPLAY variable for GUI applications
export DISPLAY=:0

# Run Livefeed
#timeout es cuanto tiempo encendido estará el feed (en segundos, ej. 300s es 5min)
# 1 5 3 significa: (1 payload) (5 calidad max) (3 camara IR)
timeout 300 /home/$USER/Edge-SDK/build/bin/test_liveview 1 5 3
