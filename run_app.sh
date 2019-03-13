#!/bin/sh

sudo rm /usr/share/X11/xorg.conf.d/99-fbturbo.conf
export LIBGL_DEBUG=verbose
export VC4_DEBUG=qir
export LD_LIBRARY_PATH="/home/pi/work/install/usr/lib/arm-linux-gnueabihf"
export LIBGL_DRIVERS_PATH="/home/pi/work/install/usr/lib/arm-linux-gnueabihf/dri"

$@
