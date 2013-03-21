#!/bin/bash
#########################################################
#   Filename   : populate.sh                             #
#   Description: TODO   #
#########################################################

PROGNAME="$(basename $0)"
quiet=false

reference="$HOSTNAME"
testname="notset"
data="default"
level="0"

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

function send {
    local testname="$1"
    local reference="$2"
    local level="$3"
    local data="$4"

    local timestamp="$(date +%s)"
    local request="" 
    
    request="reference=$reference&test=$testname&timestamp=$timestamp"
    request="$request&level=$mem&data=$data"
    
    curl "$url?$request"
}



