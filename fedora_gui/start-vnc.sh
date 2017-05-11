#!/bin/sh

Xvfb :1 -screen 0 1024x768x24 &
sleep 5
x11vnc -noxdamage -many -display :1 -rfbport 5901 -rfbauth ~/.x11vnc/passwd -bg
sleep 2
xfce4-session &

bash
# while true; do sleep 1000; done
