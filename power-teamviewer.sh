#!/bin/bash
systemctl start teamviewerd
/opt/teamviewer/tv_bin/script/teamviewer
systemctl stop teamviewerd