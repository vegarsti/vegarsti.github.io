#!/bin/bash

edit() {
    local DRAFT_DIR="_drafts"
    printf "Drafts in draft directory $DRAFT_DIR:\n"
    local MY_ARRAY=(`find "$DRAFT_DIR" -name "*.md"`)
    local INDEX=0
    local HUMAN_READABLE_INDEX=1
    for ELEMENT in "${MY_ARRAY[@]}"
    do
        printf "\t $HUMAN_READABLE_INDEX "
        basename "$ELEMENT" .md
        let INDEX="${INDEX}"+1
        let HUMAN_READABLE_INDEX="${HUMAN_READABLE_INDEX}"+1
    done
    read -p "Edit which draft? (0 to quit.) " CHOICE
    local CHOICE_IF_INTEGER="$(echo "$CHOICE" | grep -E ^\-?[0-9]+$)"
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
    local FILENAME="${MY_ARRAY[$ACTUAL_CHOICE]}"
    open "$FILENAME"
    echo "Opening draft '$FILENAME'!"
}

edit