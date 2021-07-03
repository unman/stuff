#!/bin/bash
mkdir /home/user/tmp
sudo mount -t tmpfs -o size=2G new /home/user/tmp/
qvm-pool --add newer file -o revisions_to_keep=1,dir_path=/home/user/tmp/
qvm-create new -P newer -t debian-10 -l purple --property netvm=tor
qvm-run new firefox-esr

