#!/usr/bin/bash
ID=`xdotool getwindowfocus`
QUBE=$(xprop _QUBES_VMNAME -id $ID|cut -f2 -d\" )
if [[ "$QUBE" == "_QUBES_VMNAME:  not found." ]]; then
  notify-send "That is a dom0 window"
  exit
fi
WM_CLASS=$(xprop WM_CLASS -id $ID |cut -f2 -d, |tr -d '"' )
IFS=':' read QUBE APP <<< $WM_CLASS
app=$(echo $APP | tr '[:upper:]' '[:lower:]')
qls=$(qvm-ls -O NAME,CLASS,TEMPLATE,LABEL,NETVM $QUBE --raw-data)
IFS='|' read NAME CLASS TEMPLATE LABEL NETVM QUBE APP <<< $qls
if [ $CLASS != "DispVM" ];then
  notify-send "You called a program to convert a disposable in to an AppVM.
This is not a disposable"
  exit
else
  dispvm=$(qvm-prefs $NAME default_dispvm )
  notify-send "Pausing dispvm and preparing replacement AppVM"
  qvm-pause $NAME
  real_template=`qvm-prefs $TEMPLATE template`
  new_qube=`echo $NAME |sed s/disp/qube/ `
  if [ qvm-check $new_qube ]; then
    notify-send "$new_qube already exists"
    qvm-unpause $NAME
    exit
  fi
  qvm-create $new_qube -t $real_template --property default_dispvm=$dispvm --property netvm=$NETVM -l purple
  cd /dev/qubes_dom0
  sudo dd if=$(readlink /dev/qubes_dom0/vm-$NAME-private-snap) of=$(readlink /dev/qubes_dom0/vm-$new_qube-private) conv=sparse
  qvm-unpause $NAME
  qvm-kill $NAME
  notify-send "Starting replacement AppVM"
  qvm-run $new_qube $app
fi
