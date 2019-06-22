#!/bin/bash
VALUE=$(grep namafile config/config.cfg | cut -d '=' -f 2)
namaexec=$(echo "$VALUE" | cut -f 1 -d '.')

cd /home/ccxex29/Programming/C/executable-binaries/ || exit
#START=$(date +%s)
res1=$(date +%s.%N)

# do stuff in here

#xfce4-terminal -x bash -c "START=$(date +%s);/home/ccxex29/Programming/C/executable-binaries/'$namaexec';END=$'(date +%s)';DIFF=$'(($END-$START))';printf '\n====================\nExecution Time $DIFF\n====================\n' ;read -p 'Enter to continue'"
/home/ccxex29/Programming/C/executable-binaries/$namaexec
#END=$(date +%s)
#DIFF=$(($END-$START))

res2=$(date +%s.%N)
dt=$(echo "$res2 - $res1" | bc)
dd=$(echo "$dt/86400" | bc)
dt2=$(echo "$dt-86400*$dd" | bc)
dh=$(echo "$dt2/3600" | bc)
dt3=$(echo "$dt2-3600*$dh" | bc)
dm=$(echo "$dt3/60" | bc)
ds=$(echo "$dt3-60*$dm" | bc)
ds=$(echo "$dt3" | bc)
printf "\n====================================================\nExecution Time %02.4f second(s) with exit status $?\n====================================================\n" $ds
read -p "Enter to continue"