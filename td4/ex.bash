#!/bin/bash

# 检查是否提供了文件名参数
if [ $# -eq 0 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

# 检查文件是否存在
if [! -f $1 ]; then
    echo "Fichier $1 inexistant"
    exit 1
fi

# 处理创建或删除账户的函数
process_accounts() {
    local action=$1
    while read line; do
        # 跳过注释行
        if [[ $line =~ ^# ]]; then
            continue
        fi

        # 提取姓和名
        name=$(echo $line | awk '{print $2}')
        firstname=$(echo $line | awk '{print $3}')

        # 生成登录名
        login=$(echo $name | cut -c1-2)$(echo $firstname | cut -c1-2)
        login=$(echo $login | tr '[:upper:]' '[:lower:]')

        # 生成主目录名
        homedir="/home/$(echo $name | tr '[:upper:]' '[:lower:]')$(echo $firstname | cut -c1-2)"

        # 生成注释
        comment="$firstname $name - TP ADMIN LINUX"

        if [ "$action" == "create" ]; then
            # 获取下一个可用的 UID
            uid=$(grep '^UID_MIN' /etc/login.defs | awk '{print $2}')
            while getent passwd | cut -d: -f3 | grep -q "^$uid$"; do
                ((uid++))
            done

            # 创建用户账户
            useradd -m -d $homedir -u $uid -g users -c "$comment" -s /bin/bash -p $(openssl passwd -1 'guest') $login
            echo "Compte $login créé avec succès"
        elif [ "$action" == "delete" ]; then
            # 删除用户账户及目录
            userdel -r $login
            if [ $? -eq 0 ]; then
                echo "Suppression du compte $login : [OK]"
            else
                echo "Suppression du compte $login : [ERROR]"
            fi
        fi
    done < $1
}

# 根据参数决定执行创建或删除操作
if [ "$2" == "-del" ]; then
    process_accounts "delete"
else
    process_accounts "create"
fi