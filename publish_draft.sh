#!/bin/bash

publish() {
    local DRAFT_DIR="_drafts"
    local POSTS_DIR="_posts"
    printf "Drafts in draft directory %s:\\n" "$DRAFT_DIR"
    local DRAFT_FILES=()
    while IFS= read -d $'\0' -r file; do
        DRAFT_FILES=("${DRAFT_FILES[@]}" "$file")
    done < <(find "$DRAFT_DIR" -name "*.md" -print0)

    local INDEX=0
    local HUMAN_READABLE_INDEX=1
    for ELEMENT in "${DRAFT_FILES[@]}"; do
        printf "\\t %s " "$HUMAN_READABLE_INDEX"
        basename "$ELEMENT" .md
        (( INDEX="${INDEX}"+1 ))
        (( HUMAN_READABLE_INDEX="${HUMAN_READABLE_INDEX}"+1 ))
    done
    local CHOICE
    read -r -p "Publish which draft? (0 to quit.) " CHOICE
    local CHOICE_IF_INTEGER
    CHOICE_IF_INTEGER="$(echo "$CHOICE" | grep -E '^\-?[0-9]+$')"
    if [[ -z "$CHOICE_IF_INTEGER" ]]; then
        echo "Not a valid choice!"
        exit 1
    else
        if [ "$CHOICE_IF_INTEGER" = "0" ]; then
            echo "Quitting."
            exit 1
        fi
    fi
    local ACTUAL_CHOICE="${CHOICE}"-1
    if [[ "$ACTUAL_CHOICE" -lt 0 || "$ACTUAL_CHOICE" -gt "$INDEX"-1 ]]; then
        echo "Not a valid choice!"
        exit 1
    fi
    local FILENAME="${DRAFT_FILES[$ACTUAL_CHOICE]}"
    local BASENAME
    local BASENAME_WITHOUT_FILE
    BASENAME="$(basename "$FILENAME")"
    BASENAME_WITHOUT_FILE="$(basename "$FILENAME" .md)"
    local DATE
    DATE="$(date +%Y-%m-%d)"
    local FULL_FILENAME="$POSTS_DIR/$DATE-$BASENAME"
    mv "$FILENAME" "$FULL_FILENAME"
    echo "Publishing draft '$BASENAME_WITHOUT_FILE'!"
}

publish