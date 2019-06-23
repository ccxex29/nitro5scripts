#!/bin/bash

UserName="ccxex29"
Exec="/opt/teamviewer/tv_bin/script/teamviewer"
#export DISPLAY=:0.0

sudo bash -c "systemctl start teamviewerd; echo $DISPLAY; `$Exec`; systemctl stop teamviewerd"