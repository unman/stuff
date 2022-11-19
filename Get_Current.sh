#!/bin/bash
current=$(qdbus org.kde.ActivityManager /ActivityManager/Activities  CurrentActivity)
cur_name=$(qdbus org.kde.ActivityManager /ActivityManager/Activities  ActivityName $current)

ID=`xdotool getwindowfocus`
QUBE=`xprop _QUBES_VMNAME -id $ID|cut -f2 -d\" `
if [[ "$QUBE" == "_QUBES_VMNAME:  not found." ]]; then
  name="dom0"
else
  name=$QUBE
fi
win_name=$(xprop  WM_NAME -id $ID|cut -f2 -d= )
echo $cur_name "Activity" $name $win_name|speak-ng -s225 --

