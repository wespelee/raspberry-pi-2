#!/bin/sh

SINK_NAME=record-n-play
#  pacmd list-sinks: Get defualt audio output sink
DEFAULT_OUTPUT=$(pacmd list-sinks | grep -A1 "* index" | grep -oP "<\K[^ >]+")
echo $DEFAULT_OUTPUT

pactl load-module module-combine-sink \
  sink_name=$SINK_NAME slaves=$DEFAULT_OUTPUT \
  sink_properties=device.description="Record-and-Play"

# Combine multiple output sinks 
# pactl load-module module-combine-sink sink_name=record-n-play slaves=real-output-1,real-output-2

# Record

# parec -d record-n-play.monitor | lame -r --quiet -q 3 --lowpass 17 --abr 320 - "temp.mp3"
# parec --format=s16le -d record-n-play.monitor | lame -r --quiet -q 3 --lowpass 17 --abr 192 - "temp.mp3kk"
# parec -d record-n-play.monitor | lame -r --quiet -q 3 --lowpass 17 --abr 320 - "temp.mp3" > /dev/null &1>/dev/null
# killall -q parec lame

# Reset
# pulseaudio -k

