#!/bin/bash

usage() {
    echo $'usage: ./new_draft.sh [filename] [title]'
}

create_draft_post() {
    local filename="$1"
    local title="$2"
    local draft_dir="_drafts"
    mkdir -p "$draft_dir"
    touch "$draft_dir/$filename.md"
    cat <<EOT >> "$draft_dir/$filename.md"
layout: post
title: $title
EOT
}

if [ "$#" -ne 2 ]; then
    usage
    exit 1
fi

create_draft_post "$1" "$2"