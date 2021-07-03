#!/bin/bash
qvm-kill new
qvm-remove -f new
qvm-pool -r newer
sudo umount new
rm -rf /home/user/tmp
sudo rm -rf /var/log/libvirt/libxl/new.log
sudo rm -rf /var/log/libvirt/libxl/new.log
sudo rm -rf /var/log/qubes/vm-new.log
sudo rm -rf /var/log/guid/new.log
sudo rm -rf /var/log/qrexec.new.log
sudo rm -rf /var/log/pacat.new.log
sudo rm -rf /var/log/qubesdb.new.log
