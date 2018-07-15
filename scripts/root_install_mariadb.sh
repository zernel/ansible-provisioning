#!/usr/bin/env bash

set -e

function log { echo "$(date +[\ %Y-%m-%d\ %H:%M:%S\ ]) $1" >> '/tmp/setup.log'; }

log "Install MariaDB"
yum -y install mysql-devel libcurl-devel mariadb-server mariadb
service mariadb start
log "- √ done, MariaDB started"

exit 0
