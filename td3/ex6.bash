#!/bin/bash

# 检查是否至少传入了单词长度参数
if [ $# -lt 1 ]; then
    echo "用法: $0 <单词长度> [字母位置1] [字母位置2] ..."
    exit 1
fi

# 获取单词长度
word_length=$1
shift

# 初始化匹配条件数组
declare -A conditions

# 处理字母和位置参数
for param in "$@"; do
    letter=${param:0:1}
    position=$(( ${param:1} - 1 ))
    conditions[$position]=$letter
done

# 遍历字典文件
while IFS= read -r word; do
    # 检查单词长度是否匹配
    if [ ${#word} -eq $word_length ]; then
        match=true
        # 检查每个指定位置的字母是否匹配
        for position in "${!conditions[@]}"; do
            letter=${conditions[$position]}
            if [ "${word:$position:1}" != "$letter" ]; then
                match=false
                break
            fi
        done
        # 如果所有条件都匹配，则输出单词
        if $match; then
            echo "$word"
        fi
    fi
done < /usr/share/dict/words