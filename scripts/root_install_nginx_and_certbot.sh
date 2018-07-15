#!/usr/bin/env bash

set -e

function log { echo "$(date +[\ %Y-%m-%d\ %H:%M:%S\ ]) $1" >> '/tmp/setup.log'; }

log "Install Nginx"
yum -y install nginx
log "- √ done"

log "Setup Certbot"
wget https://dl.eff.org/certbot-auto
chmod a+x ./certbot-auto
mv certbot-auto /usr/bin/certbot-auto
log "- √ done"

exit 0
