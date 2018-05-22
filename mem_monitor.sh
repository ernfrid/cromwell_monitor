#!/bin/bash

set -ueo pipefail

# Read memory stats for the machine from /proc/meminfo and convert from kB to mB.
# Output a tab-delimited line per timestamp

function note_stats {
    local dt=$(date +'%Y-%m-%d %T')
    local memtotal=$(awk '/MemTotal/ {print $2 / 1024}' /proc/meminfo)
    local memfree=$(awk '/MemFree/ {print $2 / 1024}' /proc/meminfo)
    local memavailable=$(awk '/MemAvailable/ {print $2 / 1024}' /proc/meminfo)
    echo -e "${dt}\t${memtotal}\t${memfree}\t${memavailable}"
}

echo -e "#Timestamp\tMemTotal\tMemFree\tMemAvail"
while true; do
    note_stats
    sleep 60 
done
