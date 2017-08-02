#!/bin/bash

set -ueo pipefail

function note_stats {
    local dt=$(date +'%Y-%m-%d %T')
    local memtotal=$(awk '/MemTotal/ {print $2 / 1024}' /proc/meminfo)
    local memfree=$(awk '/MemFree/ {print $2 / 1024}' /proc/meminfo)
    local memavailable=$(awk '/MemAvailable/ {print $2 / 1024}' /proc/meminfo)
    echo -e "{ 'Timestamp': ${dt}, 'MemTotal': ${memtotal}, 'MemFree': ${memfree}, 'MemAvail': ${memavailable} }"
}

while true; do 
    note_stats
    sleep 5 
done