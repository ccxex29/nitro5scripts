#!/bin/bash
CONFIG="config/config.cfg"

function set_config(){
    sed -i "s/\(namafile\s*=*\).*$/\1$name/" $CONFIG
}

# INITIALIZE CONFIG IF IT'S MISSING
if [ ! -e "${CONFIG}" ] ; then
    # Set default variable value
    touch $CONFIG
    echo "namafile=\"Test\"" | tee --append $CONFIG
fi
# LOAD THE CONFIG FILE
source $CONFIG

printf "Enter source code name :"
read name
echo "${name}" # SHOULD OUTPUT Erl
set_config $name # SETS THE NEW VALUE