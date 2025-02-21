#!/bin/bash
if [ $# -ne 1 ]; then
	echo "enter the file"
	exit 1
fi
dir_path="$1"
if [ ! -d "$dir_path" ]; then
	echo "$dir_path 不是个有效的目录"
	exit 1
fi
file_count=0
dir_count=0
for item in "$dir_path"/*; do
	if [ -f "$item" ]; then
		((file_count++))
	elif [ -d "$item" ]; then
		((dir_count++))
	fi
done
echo "目录下有$file_count个普通文件和$dir_count 个目录。"
