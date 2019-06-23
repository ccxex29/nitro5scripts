#!/bin/bash
testValue=$(systemctl --user is-active gamemoded)
GREENCOLOR='\033[1;32m'
REDCOLOR='\033[1;31m'
NOCOLOR='\033[0m'

if [[ $testValue = 'active' ]]; then 			#Exit active
	systemctl --user stop gamemoded
	xfce4-terminal -x bash -c "echo -e 'Keep in mind that you may need to remove the Preloads:\nFor steam: LD_PRELOAD=$LD_PRELOAD:/usr/\\\$LIB/libgamemodeauto.so %command%\nElse: LD_PRELOAD=/usr/\\\$LIB/libgamemodeauto.so gameexec\n\n'; printf '${REDCOLOR}GameMode service stopped!'; read -p ''"
else							#Exit inactive
	systemctl --user start gamemoded
	xfce4-terminal -x bash -c "echo -e 'To achieve a fully working GameMode, you may need to add Preloads:\nFor steam: LD_PRELOAD=$LD_PRELOAD:/usr/\\\$LIB/libgamemodeauto.so %command%\nElse: LD_PRELOAD=/usr/\\\$LIB/libgamemodeauto.so gameexec\n\n'; printf '${GREENCOLOR}GameMode service started'; read -p ''"
fi