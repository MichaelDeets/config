#!/bin/bash
set -a
LD_PRELOAD=""
xrandr --output HDMI-1 --off

GAMEEXE=csgo_linux64
GAMEROOT=$(cd "${0%/*}" && echo $PWD)
export LD_LIBRARY_PATH="${GAMEROOT}"/bin:"${GAMEROOT}"/bin/linux64:$LD_LIBRARY_PATH

LAUNCHOPTS="-nopreload -novid -nojoy -no-browser -nohltv -vulkan -tickrate 128 -softparticlesdefaultoff -toconsole"
LD_PRELOAD="/usr/lib64/libSDL2-2.0.so.0:/usr/lib/dxvk-native/x64/libdxvk_d3d9.so"

. ~/.cs/envvars.sh

vibrant-cli DP-2 2
xrandr --output DP-2 --scale 1x1 --mode 1920x1080 --rate 390 --filter nearest --brightness 1 --gamma 1.5

STATUS=42
UNAME=`uname`
cd "$GAMEROOT"
while [ $STATUS -eq 42 ]; do
	${SCHEDRT} ionice -c 2 -n 0 "${GAMEROOT}"/${GAMEEXE} $LAUNCHOPTS "$@"
	STATUS=$?
done

vibrant-cli DP-2 1
xrandr --output DP-2 --mode 1920x1080 --rate 390 --scale 1x1 --brightness 1 --gamma 1
xrandr --output HDMI-1 --off;xrandr --output HDMI-1 --mode 3840x2160 --scale 0.8x0.8 --right-of DP-2 --filter nearest --rate 120
exit $STATUS
