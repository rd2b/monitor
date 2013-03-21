#!/bin/bash
#########################################################
#   Filename   : populate.sh                             #
#   Description: TODO   #
#########################################################

PROGNAME="$(basename $0)"
quiet=false
testnumber=10
hostnumber=10

testname="memory"

url="http://my-mon.appspot.com/event"


set -u
set -e

# Prints help message
function showhelp {
    cat >&2 <<- EOF 
Usage: $PROGNAME [OPTION] ...
Options:
    -h  prints this help message.
EOF
}

# Prints log message to default output
function log {
    local level="$1"
    local message="$2"

    $quiet || echo "$(date +"%F %T" ) $PROGNAME: $message" 
}

while getopts "t:H:qh" opt
do
    case $opt in
        q)  quiet=true
            ;;
        h)  showhelp
            exit 1
            ;;
        *)  showhelp
            exit 1
            ;;
    esac
done

data="default"

memtotal=$(sed -n "s/MemTotal: \(.*\) kB/\1/p" /proc/meminfo)
memfree=$(sed -n "s/MemFree: \(.*\) kB/\1/p" /proc/meminfo)
mem=$((100*($memtotal-$memfree)/$memtotal))


timestamp="$(date +%s)"
level="$RANDOM"
request="reference=$HOSTNAME&test=$testname&timestamp=$timestamp"
request="$request&level=$mem&data=$data"

curl "$url?$request"

