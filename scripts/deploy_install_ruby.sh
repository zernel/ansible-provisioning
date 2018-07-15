#!/usr/bin/env bash

set -e

function log { echo "$(date +[\ %Y-%m-%d\ %H:%M:%S\ ]) $1" >> '/tmp/setup.log'; }

# Make sure this script is running by deploy
if [[ "$(whoami)" == "root" ]]; then
  log "ALERT: Please run as user 'deploy' not root"
  exit 1
fi

export RUBY_VERSION=$1

log "Install RVM:"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
log "- √ Added GPG signature verification for RVM"
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
source ~/.profile
log "- √ done, RVM version: $(rvm -v)"

log "Install ruby $RUBY_VERSION"
rvm install $RUBY_VERSION
rvm use $RUBY_VERSION --default
log "- √ done"

log "Install bundler gem"
echo "gem: --no-rdoc --no-ri --no-document" >> ~/.gemrc
gem install bundler
log "- √ done"

exit 0
