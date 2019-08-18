#!/bin/bash

if [ ! -e dump.sql ]; then
    scp ubuntu@52.194.215.17:dump.sql .
fi
docker run --name mysql -e MYSQL_DATABASE=isubata -e MYSQL_ROOT_PASSWORD=root -d -p 3306:3306 mysql:5.7
sleep 10
mysql -h127.0.0.1 -uroot -proot isubata < dump.sql
