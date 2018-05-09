#!/bin/bash

publish() {
    local DRAFT_DIR="_drafts"
    local POSTS_DIR="_posts"
    printf "Drafts in draft directory $DRAFT_DIR:\n"
    local my_array=(`find "$DRAFT_DIR" -name "*.md"`)
    local INDEX=0
    local HUMAN_READABLE_INDEX=1
    for element in "${my_array[@]}"
    do
        printf "\t $HUMAN_READABLE_INDEX "
        basename "$element" .md
        let INDEX="${INDEX}"+1
        let HUMAN_READABLE_INDEX="${HUMAN_READABLE_INDEX}"+1
    done
    read -p "Publish which draft? (0 to quit.) " CHOICE
    CHOICE_IF_INTEGER="$(echo "$CHOICE" | grep -E ^\-?[0-9]+$)"
    if [[ -z "$CHOICE_IF_INTEGER" ]]; then
        echo "Not a valid choice!"
        exit 1
    else
        if [ "$CHOICE_IF_INTEGER" = "0" ]; then
            echo "Quitting."
            exit 1
        fi
    fi
    let ACTUAL_CHOICE="${CHOICE}"-1
    local FILENAME="${my_array[$ACTUAL_CHOICE]}"
    local BASENAME="$(basename $FILENAME)"
    local DATE=`date +%Y-%m-%d`
    local FULL_FILENAME="$POSTS_DIR/$DATE-$BASENAME"
    mv "$FILENAME" "$FULL_FILENAME"
}


publish