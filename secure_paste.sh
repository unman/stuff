#!/usr/bin/bash
ID=`xdotool getwindowfocus`
WM_CLASS=`xprop WM_CLASS -id $ID |cut -f2 -d, |tr -d '"' `
QUBE=`xprop _QUBES_VMNAME -id $ID|cut -f2 -d\" `
#echo $QUBE >> /home/user/log
if [[ "$QUBE" == "_QUBES_VMNAME: not found." ]]; then
  exit
else
  qvm-run $QUBE '/home/user/spaste.sh'
fi
