#!/bin/bash
#########################################################
#   Filename   : install.sh                             #
#   Description: TODO   #
#########################################################

PROGNAME="$(basename $0)"
quiet=false

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

while getopts "o:qh" opt
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

cd /usr/local/
git clone https://github.com/rd2b/monitor.git
cd -

mkdir -p /etc/monitor
cp /usr/local/monitor/conf/monitor.conf /etc/monitor/
