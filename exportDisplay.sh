#!/bin/bash
displayName=$(cat ~/.dispName.txt)
echo "$displayName"
export DISPLAY="$displayName"
