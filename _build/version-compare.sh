#!/usr/bin/env bash

set -eo pipefail

LEFT="$1"
COMPARE="$2"
RIGHT="$3"

LEFT=$(echo "$LEFT" | sed 's/-.*//')
RIGHT=$(echo "$RIGHT" | sed 's/-.*//')

VERSIONS=$(echo -e "$LEFT\n$RIGHT" | sort -V)
LOWER_VERSION=$(echo "$VERSIONS" | head -1)
UPPER_VERSION=$(echo "$VERSIONS" | tail -1)

case "$COMPARE" in
    "<")
        if [[ "$LEFT" == "$LOWER_VERSION" && "$LEFT" != "$RIGHT" ]]; then
            exit
        fi
        ;;
    "<=")
        if [[ "$LEFT" == "$LOWER_VERSION" ]]; then
            exit
        fi
        ;;
    ">=")
        if [[ "$LEFT" == "$UPPER_VERSION" ]]; then
            exit
        fi
        ;;
    ">")
        if [[ "$LEFT" == "$UPPER_VERSION" && "$LEFT" != "$RIGHT" ]]; then
            exit
        fi
        ;;
esac

exit 128

