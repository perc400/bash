#!/bin/bash

### Cкрипт, который проверяет доступность набора серверов (IP-адресов) и портов из списка.
### Если какой-либо сервер или порт недоступен, скрипт должен записать в лог файл сообщение об этом.
### Список серверов и портов должен быть в отдельном файле в формате IP:port (например, 192.168.1.1:80).
### nc
### awk, grep, echo
### date

set -e

services_file="host_ip"
log_file="$(date '+%Y-%m-%d-%H-%M').log"

while read -r line; do
	address=$(echo "$line" | awk -F':' '{print $1}')
	port=$(echo "$line" | awk -F':' '{print $2}')
	
	if [[ $(nc -zvv "$address" "$port" 2>&1 | grep SUCCESS) ]]; then
		echo "$(date): $address:$port - available" >> "$log_file"
	else
		echo "$(date): $address:$port - connection refused" >> "$log_file"
	fi
done < "$services_file"

