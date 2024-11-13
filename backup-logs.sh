#!/bin/bash

### Ежедневно архивировать и сохранять логи из директории /var/log
### в отдельную папку /backup/logs/YYYY-MM-DD (текущая дата).
### Бэкапы, которым больше 7 дней, автоматически удаляются.
### tar, find, rm

set -e

backup_dir="/backup/logs"

function create_tar {
	archive_name="$(date --rfc-3339=date)"
	mkdir -p "$backup_dir/$archive_name"
	
	tar -cJf "$backup_dir/$archive_name/logs-$archive_name.tar.xz" -C / var/log/*
}

create_tar

expired_time=7
find "$backup_dir" -type d -name "*" -mtime +$expired_time -exec rm -rf {} \;
