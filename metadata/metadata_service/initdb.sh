#! /usr/bin/env bash
set -e
CMD_STATUS=1
while [ "$CMD_STATUS" -ne 0 ]; do
	echo "MySQL DB is not up yet, sleeping ..."
	sleep 10
	SQL_RESULT=$(mysql -h$PROXY_HOST -P$PROXY_PORT -u$PROXY_USER -p$PROXY_PASSWORD -e "status")
	CMD_STATUS=$?
done
echo "MySQL DB is running ..."
mysql -h$PROXY_HOST -P$PROXY_PORT -u$PROXY_USER -p$PROXY_PASSWORD -e "CREATE DATABASE IF NOT EXISTS amundsen;"

echo "init or upgrade db"
flask rds initdb
