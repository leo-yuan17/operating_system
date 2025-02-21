#!/bin/bash
TRASH_DIR=".poubelle"
if [ ! -d "$TRASH_DIR" ]; then
	mkdir "$TRASH_DIR"
fi
find "$TRASH_DIR" -type f -mtime +30 -exec rm -f {} \;
find "$TRASH_DIR" -type d -empty -mtime +30 -exec rmdir {} \;
CURRENT_DATE=$(date +%Y%m%d)
for item in "$@"; do
	if [ -e "$item" ]; then
		cp -r "$item" "$TRASH_DIR/${item}_$CURRENT_DATE"
		rm -rf "$item"
	else
		echo "$item doesn't exist"
	fi
done
