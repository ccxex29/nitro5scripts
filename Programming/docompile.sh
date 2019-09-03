#!/bin/bash

printf "Compiler Message:\n"
VALUE=`grep namafile config/config.cfg | cut -d '=' -f 2`
#namafile=$(getval "namafile")
namaexec=`echo "$VALUE" | cut -f 1 -d '.'`
#echo $namaexec
extension=`echo "$VALUE" | cut -d '.' -f 2`
argumentsC=-Wall
argumentsCexl=-lm -lncurses -lpthread
argumentsCPPexl=

#echo $extension
if [[ $extension = 'c' ]]; then
	printf 'Compiling a C Source Code\n'
	gcc $HOME/Programming/C/source-codes/"$VALUE" -o $HOME/Programming/C/executable-binaries/"$namaexec" $argumentsC $argumentsCexl
	printf '\n====================\n'
	read -p "Enter to continue"
elif [[ $extension = 'cpp' ]] || [[ $extension = 'cxx' ]] || [[ $extension = 'cc' ]] || [[ $extension = 'C' ]] || [[ $extension = 'c++' ]]; then
	printf 'Compiling a C++ Source Code\n'
	g++ $HOME/Programming/C++/source-codes/"$VALUE" -o $HOME/Programming/C++/executable-binaries/"$namaexec" $argumentsC $argumentsCPPexl
	printf '\n====================\n'
	read -p "Enter to continue"
elif [[ $extension = 'kt' ]]; then
	printf 'Compiling a Kotlin Source Code\n'
	kotlinc $HOME/Programming/C/source-codes/"$VALUE" -include-runtime -d $HOME/Programming/C/executable-binaries/"$namaexec".jar -verbose
	printf '\n====================\n'
	read -p "Enter to continue"
else
	printf 'Unknown extension\n'
	printf 'Available Compilers: C, C++, Kotlin\n'
fi
