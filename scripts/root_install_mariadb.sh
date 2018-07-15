#!/usr/bin/env bash

set -e

deploy_log "Install MariaDB"
yum -y install mysql-devel libcurl-devel mariadb-server mariadb
service mariadb start
deploy_log "- √ done, MariaDB started"

exit 0
