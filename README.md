# stuff

Mixed Qubes stuff

`qfind.sh` is a simple script that identifies the qube of the currently active window.  
Use it as a template for action scripts, and bind them to a shortcut.

## KDE Activities
In KDE, it is useful to be able to switch activities from the keyboard.
Meta+Tab will cycle through activities, ordered by the most recently used.  
If you want to switch to a particular activity, use `Get_Activity.sh` to find the UUID of the activity in which it is run.

Then use `Switch_Activity.sh` as a template for action scripts, bound to a keyboard shortcut.  
You will need to enter the UUID in the script.

## RAM qubes
`ramqube.sh` and `rmram.sh` are simple scripts to create qubes in a RAM disk pool, and clean up when done.

## in.sh
`in.sh` is a simple script to allow external access to a qube, regardless of how deeply nested it is.
E.g. `in.sh add target tcp 22` will create rules on all relevant netvms allowing remote ssh access to the target qube.
