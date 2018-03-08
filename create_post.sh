#!/bin/bash

usage() {
    local SCRIPT_NAME="$(basename \"$0)"
    printf $'usage: %s [filename] [title]\n' "$SCRIPT_NAME"
}

create_post() {
    local DATE=`date +%Y-%m-%d`
    local FILENAME="$1"
    local TITLE="$2"
    local POSTS_DIR="_posts"
    mkdir -p "$POSTS_DIR"
    local FULL_FILENAME="$POSTS_DIR/$DATE-$FILENAME.md"
    touch "$FULL_FILENAME"
    cat <<EOT >> "$FULL_FILENAME"
---
layout: post
title: $TITLE
---
EOT
}

if [ "$#" -ne 2 ]; then
    usage
    exit 1
fi

create_post "$1" "$2"