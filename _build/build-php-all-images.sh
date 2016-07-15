#!/usr/bin/env bash

set -eo pipefail

die() {
    >&2 echo -e "\033[91m * \033[0m$1";
    exit 128;
}

info() {
    echo -e "\033[96m * \033[0m$1";
}

success() {
    echo -e "\033[92m * \033[0m$1";
}


PATHNAMES=$(find php-all -mindepth 2 -maxdepth 2 -type d | sort -V)

for PATHNAME in $PATHNAMES; do
    VERSION=$(echo "$PATHNAME" | awk -F '/' '{print $2}')
    KIND=$(echo "$PATHNAME" | awk -F '/' '{print $3}')

    info "Build bit3/php-all:$VERSION-$KIND"
    echo docker build -t "bit3/php-all:$VERSION-$KIND" "$PATHNAME"
done
