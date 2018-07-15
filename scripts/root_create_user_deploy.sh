#!/usr/bin/env bash

set -e

deploy_log "Prepare user 'deploy':"
if id deploy >/dev/null 2>&1; then
  deploy_log "- * already exists, skipped"
else
  adduser deploy

  deploy_log "- * Copy root's SSH authorized_keys to deploy"
  mkdir /home/deploy/.ssh/
  cp /root/.ssh/authorized_keys /home/deploy/.ssh/authorized_keys
  chown deploy:deploy /home/deploy/.ssh/authorized_keys

  deploy_log "- * Prepare /apps folder for user 'deploy'"
  mkdir -p /apps
  chown deploy:deploy /apps -R
  [ ! -d "/home/deploy/apps" ] && ln -s /apps /home/deploy/
  deploy_log "- √ done"
fi

exit 0
