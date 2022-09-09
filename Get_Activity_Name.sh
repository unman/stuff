#!/bin/sh
qdbus org.kde.ActivityManager /ActivityManager/Activities ActivityName `qdbus org.kde.ActivityManager /ActivityManager/Activities CurrentActivity`
