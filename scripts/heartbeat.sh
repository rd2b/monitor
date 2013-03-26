#!/bin/bash
#########################################################
#   Filename   : populate.sh                             #
#   Description: TODO   #
#########################################################

PROGNAME="$(basename $0)"
quiet=false
CONFFILE="/etc/monitor/monitor.conf"                                            
url="http://my-mon.appspot.com/event"                                           
source $CONFFILE  

testname="heartbeat"
level="$(date +%Y%m%d%H%M)"


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

timestamp="$(date +%s)"
request="reference=$HOSTNAME&test=$testname&timestamp=$timestamp"
request="$request&level=$level&data=$data"

curl -s "$url?$request"

