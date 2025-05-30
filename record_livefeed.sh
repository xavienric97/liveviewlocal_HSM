#!/bin/bash

# # Wait for the PayloadCamera window to appear
# while ! wmctrl -l | grep -q "PayloadCamera"; do
#     sleep 1
# done

# # Get the window ID
# WIN_ID=$(xdotool search --name "PayloadCamera" | head -n 1)

# # Start recording the specific window using ffmpeg
# ffmpeg -y -f x11grab -i :0.0+0,0 -window_id "$WIN_ID" -vcodec libx264 -preset ultrafast test_fullscreen.mp4

#---------------------------------------------------------------------------------------------------------------------------------------

# # Wait for the PayloadCamera window to appear
# while ! wmctrl -l | grep -q "PayloadCamera"; do
#     sleep 1
# done

# # Get the window ID
# WIN_ID=$(xdotool search --name "PayloadCamera" | head -n 1)

# # Start recording in the background
# ffmpeg -y -f x11grab -window_id "$WIN_ID" -vcodec libx264 -preset ultrafast test_fullscreen.mp4 &

# # Get the ffmpeg process ID
# FFMPEG_PID=$!

# # Monitor the PayloadCamera window
# while wmctrl -l | grep -q "PayloadCamera"; do
#     sleep 1
# done

# # Stop recording once PayloadCamera is closed
# kill $FFMPEG_PID
# echo "Recording stopped because 'PayloadCamera' window disappeared."

#--------------------------------------------------------------------------------------------------------------------------------------

# # Wait for the PayloadCamera window to appear
# while ! wmctrl -l | grep -q "PayloadCamera"; do
#     sleep 1
# done

# # Get the window ID
# WIN_ID=$(xdotool search --name "PayloadCamera" | head -n 1)

# # Get window geometry (position and size)
# eval $(xdotool getwindowgeometry --shell "$WIN_ID")

# # Start recording in the background
# ffmpeg -y -f x11grab -video_size ${WIDTH}x${HEIGHT} -i :0.0+${X},${Y} -vcodec libx264 -preset ultrafast test_fullscreen.mp4 &

# # Get the ffmpeg process ID
# FFMPEG_PID=$!

# # Monitor the PayloadCamera window
# while wmctrl -l | grep -q "PayloadCamera"; do
#     sleep 1
# done

# # Stop recording once PayloadCamera is closed
# kill $FFMPEG_PID
# echo "Recording stopped because 'PayloadCamera' window disappeared."

#-----------------------------------------------------------------------------------------------------------------------------------------

# Directory to save recordings
SAVE_DIR="$HOME/Videos/recordings"

while true; do
    # Wait for PayloadCamera to appear
    while ! wmctrl -l | grep -q "PayloadCamera"; do
        sleep 2
    done

    # Get timestamp for filename (YYYYMMDD_HHMM)
    TIMESTAMP=$(date +"%Y%m%d_%H%M")

    # Get window ID
    WIN_ID=$(xdotool search --name "PayloadCamera" | head -n 1)

    # Get window geometry (position and size)
    eval $(xdotool getwindowgeometry --shell "$WIN_ID")

    # Start recording
    OUTPUT_FILE="$SAVE_DIR/recording_$TIMESTAMP.mp4"
    echo "Recording started: $OUTPUT_FILE"
    ffmpeg -y -f x11grab -video_size ${WIDTH}x${HEIGHT} -i :0.0+${X},${Y} -vcodec libx264 -preset ultrafast "$OUTPUT_FILE" &
    
    # Get ffmpeg PID
    FFMPEG_PID=$!

    # Monitor PayloadCamera, stop recording when it disappears
    while wmctrl -l | grep -q "PayloadCamera"; do
        sleep 1
    done

    # Stop recording
    kill $FFMPEG_PID
    echo "Recording stopped and saved: $OUTPUT_FILE"
    
    # Wait a moment before checking again to prevent rapid restarts
    sleep 2
done



