#!/bin/bash
cd $1
# Iterate over all text files in the directory to add layout and correct Jekyll prone error
for file in *.html; do
    #Add layout
    if ! grep -q "^---" "$file" 
    then
        sed -i '1d; 2 i ---\nlayout: default\n---' "$file"
    fi 
    # Perform the search and replace operation on each file
    perl -i -pe 's/\{\{(.*?)\}\}/\{\1\}/g' "$file"
done
