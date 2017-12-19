#!/bin/bash

usage() {
    local script_name="$(basename \"$0)"
    printf $'usage: %s [filename] [title]\n' "$script_name"
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