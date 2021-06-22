#!/bin/bash
ID=`xdotool getwindowfocus`
QUBE=`xprop _QUBES_VMNAME -id $ID|cut -f2 -d\" `
if [[ "$QUBE" == "_QUBES_VMNAME:  not found." ]]; then
  exit
else
# Do something with $QUBE
fi
