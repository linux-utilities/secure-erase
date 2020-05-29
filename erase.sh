#!/usr/bin/env bash

ITERATIONS=32
if [[ ! -z "$1" ]]; then
    ITERATIONS="$1"
fi

MAX_SIZE=$(ls -l | grep -v "${0:2}" | sed -e 's/[ ]\+/ /g' | grep -v "total" | cut -d ' ' -f 5 | sort -n | tail -n1)
FILES=$(ls | grep -v "${0:2}" | xargs echo)

for FILE in $FILES; do
    for i in {1..$ITERATIONS}; do
        sudo dd if=/dev/urandom bs=1 count=$MAX_SIZE of=$FILE &>/dev/null
        echo "$FILE has been secure erased"
    done
done
