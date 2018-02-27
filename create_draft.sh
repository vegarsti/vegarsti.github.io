#!/bin/bash

usage() {
    local SCRIPT_NAME="$(basename \"$0)"
    printf $'usage: %s [filename] [title]\n' "$SCRIPT_NAME"
}

create_draft_post() {
    local FILENAME="$1"
    local TITLE="$2"
    local DRAFT_DIR="_drafts"
    mkdir -p "$DRAFT_DIR"
    local FULL_FILENAME="$DRAFT_DIR/$FILENAME.md"
    cat <<EOT >> "$FULL_FILENAME"
---
layout: post
title: $TITLE
---
EOT
    open "$FULL_FILENAME"
}

if [ "$#" -ne 2 ]; then
    usage
    exit 1
fi

create_draft_post "$1" "$2"