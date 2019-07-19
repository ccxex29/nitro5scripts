#!/bin/bash

printf -v FILES '%d\n' $(ls -l backups/xfce | grep -E -c '^-')

function show_help {
	printf "\n"
	printf "%s\n\n" "XFCE Backup by ccxex29"
	printf "%-32s %s\n" "-h or --help" "to show help"
	printf "%-32s %s\n" "-r, -rm, --remove, or --purge" "to remove all saved backups"
	printf "%-32s\n" "Remaining files after remove can be determined by adding number of files to be left."
	printf "\n"
}


if [[ "$1" = "-r" ]] || [[ "$1" = "--remove" ]] || [[ "$1" = "--purge" ]]; then
	if [[ "$2" != "" ]] && [[ "$2" > 0 ]]; then
		MANY=$2
	else
		MANY=0
	fi
	
	while [ $FILES -gt $MANY ]
	do
		rm backups/xfce/$(ls -t backups/xfce | tail -1)
		printf -v FILES '%d\n' $(ls -l backups/xfce | grep -E -c '^-')
	done
elif [[ "$1" = "-h" ]] || [[ "$1" = "--help" ]]; then
	show_help
elif [[ "$1" = "" ]]; then
	TIMENOW=$(date +%Y_%m_%d_%H%M%S)
	MAXFILES=10
	printf -v MILIS '%d\n' $(date +%-N)
	MILIS=$(expr $MILIS / 10000000)

	### Debugging ###
	#echo $FILES
	#echo "$(date +%S) $MILIS"
	#echo $TIMENOW

	while [ $FILES -ge $MAXFILES ]
	do
		rm backups/xfce/$(ls -t backups/xfce | tail -1)
		printf -v FILES '%d\n' $(ls -l backups/xfce | grep -E -c '^-')
	done

	mkdir -p backups/xfce-desktop-backup &
	mkdir -p backups/xfce-desktop-backup/thunar &
	mkdir -p backups/xfce-desktop-backup/xfce-settings &
	wait

	cp -R ~/.config/xfce4/ backups/xfce-desktop-backup/xfce-settings &
	cp -R ~/.config/Thunar/ backups/xfce-desktop-backup/xfce-settings &
	wait

	tar -czvf backups/xfce/xfce4-backup-$TIMENOW\_$MILIS.tar.gz backups/xfce-desktop-backup > /dev/null

	rm -R backups/xfce-desktop-backup 
else
	printf "Unknown Argument \"$1\" !\n\n"
	show_help
fi