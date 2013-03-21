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
source $LIBMONITOR


reference="$HOSTNAME"
testname="notset"
data="default"
level="0"



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

while getopts "t:r:l:d:qh" opt
do
    case $opt in
        t)  testname=$OPTARG
            ;;
        r)  reference=$OPTARG
            ;;
        l)  level=$OPTARG
            ;;
        d)  data=$OPTARG
            ;;
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

send "$testname" "$reference" "$level" "$data"

