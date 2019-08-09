#!/bin/bash
testValue=$(systemctl --user is-active gamemoded)
GREENCOLOR='\033[1;32m'
REDCOLOR='\033[1;31m'
NOCOLOR='\033[0m'

printf "Gamemode is currently "
if [[ $testValue = 'active' ]]; then 			#Exit active
	printf "${GREENCOLOR}active${NOCOLOR}\n\n"
	read -p 'Deactivate (Y/n) ? ' userSwitchP
	userSwitchP=$(echo "$userSwitchP" | awk '{print tolower($0)}')
	if [[ $userSwitchP == 'y' ]] || [[ $userSwitchP == 'yes' ]] || [[ $userSwitchP == '' ]]; then
		systemctl --user stop gamemoded
		xfce4-terminal -x bash -c "echo -e 'Keep in mind that you may need to remove the Preloads:\nFor steam: LD_PRELOAD=$LD_PRELOAD:/usr/\\\$LIB/libgamemodeauto.so %command%\nElse: LD_PRELOAD=/usr/\\\$LIB/libgamemodeauto.so gameexec\n\n'; printf '${REDCOLOR}GameMode service stopped!'; read -p ''"
	fi
else							#Exit inactive
	printf "${REDCOLOR}inactive${NOCOLOR}\n\n"
	read -p 'Activate (Y/n) ? ' userSwitchP
	userSwitchP=$(echo "$userSwitchP" | awk '{print tolower($0)}')
	if [[ $userSwitchP == 'y' ]] || [[ $userSwitchP == 'yes' ]] || [[ $userSwitchP == '' ]]; then
		systemctl --user start gamemoded
		xfce4-terminal -x bash -c "echo -e 'To achieve a fully working GameMode, you may need to add Preloads:\nFor steam: LD_PRELOAD=$LD_PRELOAD:/usr/\\\$LIB/libgamemodeauto.so %command%\nElse: LD_PRELOAD=/usr/\\\$LIB/libgamemodeauto.so gameexec\n\n'; printf '${GREENCOLOR}GameMode service started'; read -p ''"
	fi
fi
