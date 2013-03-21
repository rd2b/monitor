#!/bin/bash
#########################################################
#   Filename   : disk.sh                             #
#   Description: TODO   #
#########################################################

PROGNAME="$(basename $0)"
quiet=false

set -u
set -e
defaultdiskwarning=40

dfresult=$(df -P |grep -v "Filesystem" |sed 's/[[:space:]]\+/;/g')

data="Disk stats: \n"

result=0

echo "$dfresult" | while IFS=";" read -r fs total used available use mountpoint
do
    
    diskfull=$((100*($total-$available)/$total))    

    limit=$defaultdiskwarning
    if [ $diskfull -gt $limit ]
    then
        echo "KO $mountpoint $diskfull% (>$limit%)\n"
        result=1
    else
        echo "OK $mountpoint $diskfull% (<$limit%)\n"
    fi
done

echo "$data"
