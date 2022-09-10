#!/usr/bin/bash
mapfile KDE_ACTIVITIES < <(kactivities-cli --list-activities|cut -f2 -d" ")
NUMBER_ACTIVITIES="${#KDE_ACTIVITIES[@]}"
CURRENT=`qdbus org.kde.ActivityManager /ActivityManager/Activities CurrentActivity`
for i in "${!KDE_ACTIVITIES[@]}"; do
  if [[ "${KDE_ACTIVITIES[$i]%$'\n'}" =~ "$CURRENT" ]]; then
    if [ $i -eq $((NUMBER_ACTIVITIES-1)) ]; then
      TARGET=0
    else
	    TARGET=$((i+1))
    fi
  fi
done

#xprop _QUBES_VMNAME -id $ID|cut -f2 -d\"~ `
ID=`xdotool getwindowfocus`
xprop -f _KDE_NET_WM_ACTIVITIES 8s -id $ID -set _KDE_NET_WM_ACTIVITIES  "${KDE_ACTIVITIES[$TARGET]%$'\n'}"
