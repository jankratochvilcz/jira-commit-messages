#!/usr/bin/env sh
JIRA_TICKET_REF=$(git branch --show-current | grep -E -o '\w{2}\-\d{4}') 
    
if [ -z "$JIRA_TICKET_REF" ]; then
    exit 1;
fi

JIRA_TICKET_REF_UPPERCASE=$(echo "$JIRA_TICKET_REF" | tr '[:lower:]' '[:upper:]')
ORIGINAL_MESSAGE=$(cat "$1")
FORMATTED_MESSAGE="[$JIRA_TICKET_REF_UPPERCASE] $ORIGINAL_MESSAGE"

echo $FORMATTED_MESSAGE > "$1"