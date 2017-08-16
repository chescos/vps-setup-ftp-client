#!/bin/bash

# log output
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>/root/log 2>&1

# set variables
PASS=franus1221

# set and export variables that are needed for the tightVNC setup
HOME=/root
USER=ROOT
export HOME
export USER

# change root password
echo "root:$PASS" | chpasswd

# install VNC server
sudo apt-get -y install xorg lxde-core tightvncserver

# install expect
sudo apt-get -y install expect

# configure VNC password
prog=/usr/bin/vncpasswd
/usr/bin/expect <<EOF
spawn "$prog"
expect "Password:"
send "$PASS\r"
expect "Verify:"
send "$PASS\r"
expect "Would you like to enter a view-only password (y/n)?"
send "n\r"
expect eof
exit
EOF

# setup VNC server
tightvncserver :1

# clear VNC startup config
> ~/.vnc/xstartup

# fill VNC startup config with all values
echo "#!/bin/sh

xrdb /root/.Xresources
xsetroot -solid grey
x-window-manager &
lxterminal &
/usr/bin/lxsession -s LXDE &
export XKL_XMODMAP_DISABLE=1
/etc/X11/Xsession" >> ~/.vnc/xstartup

# shutdown VNC server
tightvncserver -kill :1

# start VNC restart
vncserver :1 -geometry 1024x768 -depth 16 -pixelformat rgb565

# install firefox and filezilla
sudo apt-get -y install firefox filezilla

# create filezilla folder for config downloading
mkdir /root/.filezilla

# copy contents of cronjobs.txt into crontab
crontab /root/setup/cronjobs.txt
