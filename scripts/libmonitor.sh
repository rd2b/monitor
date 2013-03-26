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

set -u
set -e

# Prints log message to default output
function log {
    local level="$1"
    local message="$2"

    $quiet || echo "$(date +"%F %T" ) $PROGNAME: $message" 
}

function send {
    local testname="$1"
    local reference="$2"
    local level="$3"
    local data="$4"

    local timestamp="$(date +%s)"
    local request="" 
    
    request="reference=$reference&test=$testname&timestamp=$timestamp"
    request="$request&level=$level&data=$data"
    
    curl -s "$url?$request"
}



