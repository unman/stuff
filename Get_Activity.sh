#!/bin/bash
# This file will output the UUID of the activity where it is run.
qdbus org.kde.ActivityManager /ActivityManager/Activities  CurrentActivity
