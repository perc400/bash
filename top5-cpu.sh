#!/bin/bash

echo "Top 5 processes by CPU, RAM usage on $(date)" > "ps-$(date '+%Y-%m-%d-%H-%M').log"

ps -aux --no-headings | sort -n -k3,4 -r | head -n 5 | awk '{printf "%-8s %-8s %-5s %-5s %s\n", $1, $2, $3, $4, $11}' >> "ps-$(date '+%Y-%m-%d-%H-%M').log"
