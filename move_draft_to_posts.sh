#!/bin/bash

usage() {
    local SCRIPT_NAME="$(basename \"$0)"
    printf $'usage: %s [filename_of_draft_post]\n' "$SCRIPT_NAME"
}

move_draft_to_posts() {
    local FULL_FILENAME="$1"
    local BASENAME="$(basename $FULL_FILENAME .md)"
    echo "$BASENAME"
    local FILENAME="$(sed -E 's#^[0-9]*-[0-9]*-[0-9]*-##' <<< $BASENAME)"
    echo "$FILENAME"
    if [ "$FILENAME" == "" ]; then
        echo "error: draft post does not have a title"
        usage
        exit 1
    fi
    bash create_post.sh "$FILENAME" "$TITLE"
}

if [ "$#" -ne 1 ]; then
    usage
    exit 1
fi

move_draft_to_post "$1"