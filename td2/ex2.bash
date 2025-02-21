#!/bin/bash

if [ $# -ne 1 ]; then
    echo "用法: $0 文件名"
    exit 1
fi

file="$1"
if [ -f "$file" ]; then
    line_num=1
    while IFS= read -r line; do
        echo "$line_num $line"
        ((line_num++))
    done <"$file"
else
    echo "$file 不是一个有效的文件。"
fi
