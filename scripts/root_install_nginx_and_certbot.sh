#!/usr/bin/env bash

set -e

deploy_log "Install Nginx"
yum -y install nginx
deploy_log "- √ done"

deploy_log "Setup Certbot"
wget https://dl.eff.org/certbot-auto
chmod a+x ./certbot-auto
mv certbot-auto /usr/bin/certbot-auto
deploy_log "- √ done"

exit 0
