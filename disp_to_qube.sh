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
WM_CLASS=$(xprop WM_CLASS -id $ID |cut -f2 -d, |tr -d '"' )
IFS=':' read QUBE APP <<< $WM_CLASS
app=$(echo $APP | tr '[:upper:]' '[:lower:]')
case $app in
  libreoffice-startcenter)
    app="libreoffice --nologo"
esac
qls=$(qvm-ls -O NAME,CLASS,TEMPLATE,LABEL,NETVM $QUBE --raw-data)
IFS='|' read NAME CLASS TEMPLATE LABEL NETVM QUBE APP <<< $qls
if [ $CLASS != "DispVM" ];then
  notify-send "You called a program to convert a disposable in to an AppVM.
This is not a disposable"
  exit
else
  dispvm=$(qvm-prefs $NAME default_dispvm )
  notify-send "Pausing disposable and preparing replacement AppVM"
  qvm-pause $NAME
  real_template=`qvm-prefs $TEMPLATE template`
  new_qube=`echo $NAME |sed s/disp/qube/ `
  qvm-check --quiet $new_qube 2>/dev/null
  if [ $? -eq 0 ]; then
    notify-send "$new_qube already exists"
    qvm-unpause $NAME
    exit
  fi
  qvm-create $new_qube -t $real_template --property default_dispvm=$dispvm --property netvm=$NETVM -l $LABEL
  cd /dev/qubes_dom0
  sudo dd if=$(readlink /dev/qubes_dom0/vm-$NAME-private-snap) of=$(readlink /dev/qubes_dom0/vm-$new_qube-private) conv=sparse bs=1M
  if [ $? -eq 0 ]; then
    notify-send "Starting replacement AppVM"
    qvm-unpause $NAME
    qvm-kill $NAME
    qvm-run $new_qube 'find -name .lock* -delete'
    qvm-run $new_qube "$app" &
  else
    qvm-unpause $NAME
    notify-send "Something went wrong. Rolling back"
    qvm-remove -f $new_qube 
  fi
fi
