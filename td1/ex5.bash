#!/bin/bash
if [ $# -ne 2 ]; then
	echo "need 2 arguments"
	exit 1
fi

search_dir="$1"
search_file="$2"
if [ ! -d "$search_dir" ]; then
	echo "$search_dir 不是一个有效的目录"
	exit 1
fi
find "$search_dir" -name "$search_file"
