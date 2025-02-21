#!/bin/bash

# 检查是否提供了一个参数
if [ $# -ne 1 ]; then
    echo "用法: $0 <单词>"
    exit 1
fi

word=$1
reversed=()
for ((i = ${#word} - 1; i >= 0; i--)); do
    # 依次添加反转后的字符到数组
    reversed+=("${word:$i:1}")
done

# 将反转后的数组元素拼接成字符串
reversed_str=""
for char in "${reversed[@]}"; do
    reversed_str="$reversed_str$char"
done

if [ "$word" = "$reversed_str" ]; then
    echo "$word 是回文。"
else
    echo "$word 不是回文。"
fi
