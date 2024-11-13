#!/bin/bash

### --------------
### Проверка использования дискового пространства на сервере.
### Если использование какого-либо раздела превышает 40%,
### отправить уведомление в telegram.
### --------------
### df, mail
### awk, grep, cut

set -e

TOKEN="XXXXXXXXXX:YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY"
CHAT_ID="XXXXXX"
MESSAGE="The following partitions have exceeded 40% usage:\n"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"
i=1

for usage in $(df -h | grep -v "Use" | awk '{print $5}'); do
	part=$(df -h | grep -v "Use" | awk '{print $1}' | sed -n ${i}p)
	((i++))
	
	if [[ ${usage//%/} -gt 40 ]]; then
		MESSAGE="Usage of partition <${part}> is ${usage//%/}!!!"
		curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE"
	fi
done
