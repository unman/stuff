#!/usr/bin/bash
if [ $# -eq 1 ];then
  qvm-check --quiet $1 2>/dev/null
  if [ $? -ne 0 ]; then
    notify-send "No qube $1 "
    exit
  else
    ID=`xdotool selectwindow`
    if [ "$(xprop _QUBES_VMNAME -id $ID|cut -f2 -d\")" != "$1" ]; then
      notify-send "Window mismatch"
      exit
    fi
  fi
else
  ID=`xdotool getwindowfocus`
fi
QUBE=$(xprop _QUBES_VMNAME -id $ID|cut -f2 -d\" )
if [[ "$QUBE" == "_QUBES_VMNAME:  not found." ]]; then
  notify-send "That is a dom0 window"
  exit
fi
notify-send "opening terminal"&
qvm-run $QUBE qubes-run-terminal &
exit

