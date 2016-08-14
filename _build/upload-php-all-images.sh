#!/usr/bin/env bash

die() {
    >&2 echo -e "\033[91m * \033[0m$1";
    exit 128;
}

info() {
    if [[ $2 ]]; then
        echo -en "\033[96m * \033[0m$1";
    else
        echo -e "\033[96m * \033[0m$1";
    fi
}

error() {
    echo -e "\033[91m$1\033[0m";
}

VERBOSE=""

# Read script options
while getopts hv OPT; do
    case $OPT in
        "h") cat <<HELP
Synopsis: upload-php-all-images.sh -v

Options:
  -v    Be verbose.
HELP
            exit
            ;;
        "v")
            VERBOSE=1
            ;;
    esac
done


PATHNAMES=$(find php-all -mindepth 2 -maxdepth 2 -type d | sort -V)

for PATHNAME in $PATHNAMES; do
    VERSION=$(echo "$PATHNAME" | awk -F '/' '{print $2}')
    KIND=$(echo "$PATHNAME" | awk -F '/' '{print $3}')

    LOG="push-$VERSION-$KIND.log"


    if [[ $VERBOSE ]]; then
        info "Push bit3/php-all:$VERSION-$KIND (@see $LOG)  "
        docker push "bit3/php-all:$VERSION-$KIND"
        EXIT=$?
    else
        docker push "bit3/php-all:$VERSION-$KIND" > "$LOG"
        EXIT=$?
    fi
    
    if [[ $EXIT -ne 0 ]]; then
        error "failed"
        exit $EXIT
    fi
done

