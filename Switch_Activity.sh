#!/bin/sh
# Identify the UUID of the Activity where you want an application to be run
# Enter the UUID in the next line
qdbus org.kde.ActivityManager /ActivityManager/Activities  SetCurrentActivity <UUID>
# That will switch to the activity you chose

# You can run programs, as usual:
qvm-run work libreoffice &

# Save this file, and run it with a shortcut.
