#!/bin/bash

set -ueo pipefail

# Read memory stats for the machine from /proc/meminfo and convert from kB to mB.
# Output a tab-delimited line per timestamp

function note_stats {
    local dt=$(date +'%Y-%m-%d %T')
    local stats=$(cat /proc/meminfo)
    local memtotal=$(awk '/MemTotal/ {print $2 / 1024}' <<< "$stats")
    local memfree=$(awk '/MemFree/ {print $2 / 1024}' <<< "$stats")
    local memavailable=$(awk '/MemAvailable/ {print $2 / 1024}' <<< "$stats")
    local memused=$( awk '{ print $1 - $2 }' <<< "${memtotal} ${memavailable}" )
    echo -e "${dt}\t${memtotal}\t${memfree}\t${memavailable}\t${memused}"
}

echo -e "#Timestamp\tMemTotal\tMemFree\tMemAvail\tMemUsed"
while true; do
    note_stats
    sleep 60 
done
