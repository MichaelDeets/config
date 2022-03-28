#!/bin/bash
GAMEROOT=$(cd "${0%/*}" && echo $PWD)
UNAME=`uname`
GAMEEXE=csgo_linux64
#ulimit -n 2048
export LD_LIBRARY_PATH="${GAMEROOT}"/bin:"${GAMEROOT}"/bin/linux64:$LD_LIBRARY_PATH
export multithread_glsl_compiler=1
export AMD_TEX_ANISO=0
export MESA_NO_ERROR=1
export vblank_mode=0

#export DXVK_HUD=full
#export DXVK_CONFIG_FILE=/home/michael/.dxvk/dxvk.conf

cd "$GAMEROOT"
STATUS=42

while [ $STATUS -eq 42 ]; do
	${DEBUGGER} nice -n -10 "${GAMEROOT}"/${GAMEEXE} -vulkan -novid -nojoy -no-browser -console -nohltv -nomessagebox -nogammaramp "$@"
	STATUS=$?
done
exit $STATUS
