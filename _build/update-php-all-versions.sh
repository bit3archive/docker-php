#!/usr/bin/env bash

set -eo pipefail

die() {
    >&2 echo -e "\033[91m * \033[0m$1";
    exit 128;
}

info() {
    echo -e "\033[96m * \033[0m$1";
}

curl --version >/dev/null 2>&1 || die "curl must be installed"
jq --version >/dev/null 2>&1 || die "jq must be installed"
xmlstarlet --version >/dev/null 2>&1 || die "xmlstarlet must be installed"


# Fetch the tags
info "Fetching php versions from docker hub"
curl -s https://index.docker.io/v1/repositories/php/tags > tags.json


# Read active versions from official php container
VERSIONS=$(jq -r '.[].name' tags.json)
# filter out unsupported alpine images
VERSIONS=$(echo "$VERSIONS" | grep -v alpine)
# filter out versions with only major+minor
VERSIONS=$(echo "$VERSIONS" | grep -vE '^[[:digit:]]*\.[[:digit:]]*(-.*|$)')
# filter versions with kind
VERSIONS=$(echo "$VERSIONS" | grep -E '\-[[:alnum:]]*')
# convert the version string, into a pathname
VERSION_PATHNAMES=$(echo "$VERSIONS" | sed 's;-;/;' | sed 's;^;php-all/;' | sort -V)


# Load own container versions
if [[ -d "php-all" ]]; then
    EXISTING_VERSION_PATHNAMES=$(find php-all -mindepth 2 -maxdepth 2 -type d | sort -V)
else
    EXISTING_VERSION_PATHNAMES=""
fi


# Determine new and superfluous (deprecates) versions
if [[ -z "$EXISTING_VERSION_PATHNAMES" ]]; then
    NEW_VERSION_PATHNAMES="$VERSION_PATHNAMES"
    SUPERFLUOUS_VERSION_PATHNAMES=""
else
    DIFF=$(diff <(echo "$VERSION_PATHNAMES") <(echo "$EXISTING_VERSION_PATHNAMES"))
    NEW_VERSION_PATHNAMES=$(echo "$DIFF" | grep '< ' | cut -c 3-)
    SUPERFLUOUS_VERSION_PATHNAMES=$(echo "$DIFF" | grep '> ' | cut -c 3-)
fi


# Delete superfluous version
for PATHNAME in $SUPERFLUOUS_VERSION_PATHNAMES; do
    VERSION=$(echo "$PATHNAME" | awk -F '/' '{print $2}')
    KIND=$(echo "$PATHNAME" | awk -F '/' '{print $3}')

    info "Remove superfluous version: $VERSION-$KIND"
    rm -r "$PATHNAME"
done

# Clean empty directories
if [[ -d "php-all" ]]; then
    find php-all/ -type d -empty -delete
fi


# Create new versions
for PATHNAME in $NEW_VERSION_PATHNAMES; do
    VERSION=$(echo "$PATHNAME" | awk -F '/' '{print $2}')
    KIND=$(echo "$PATHNAME" | awk -F '/' '{print $3}')

    info "Create new version: $VERSION-$KIND"
    mkdir -p "$PATHNAME"

    ./_build/gen-dockerfile.sh -v "$VERSION" -k "$KIND" > "$PATHNAME/Dockerfile"
    cp _build/zshrc "$PATHNAME/zshrc"
done


# Cleanup
rm tags.json
