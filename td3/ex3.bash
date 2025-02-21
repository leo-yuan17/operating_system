#!/bin/bash

# 检查是否提供了一个参数
if [ $# -ne 1 ]; then
    echo "用法: $0 <单词>"
    exit 1
fi

word=$1
reversed=$(echo "$word" | rev)

if [ "$word" = "$reversed" ]; then
    echo "$word 是回文。"
else
    echo "$word 不是回文。"
fi