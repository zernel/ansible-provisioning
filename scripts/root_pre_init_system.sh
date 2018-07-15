#!/usr/bin/env bash

set -e

# Setup log
export LOG_PATH=/tmp/setup.log
# [ -e $LOG_PATH ] && rm -f $LOG_PATH # Remove log file if it already exist
touch $LOG_PATH
chmod o+w $LOG_PATH
function log { echo "$(date +[\ %Y-%m-%d\ %H:%M:%S\ ]) $1" >> $LOG_PATH; }
log "-----------------------------------------------------------------------------------------------------"
log "Linux version: $(uname -a)"

export HOSTNAME=$1
hostname $HOSTNAME
echo $HOSTNAME > /etc/hostname;
log "Set hostname: $HOSTNAME:"

log "Install EPEL and update all installed packages"
yum -y install epel-release
yum -y update
log "- * Install RVM Requirements"
yum -y install autoconf automake bison bzip2 gcc-c++ libffi-devel libtool readline-devel sqlite-devel
yum -y install curl wget git vim
log "- √ done"

log "Install NodeJS:"
rpm -ivh https://kojipkgs.fedoraproject.org//packages/http-parser/2.7.1/3.el7/x86_64/http-parser-2.7.1-3.el7.x86_64.rpm && yum -y install nodejs
log "- √ installed Nodejs $(node -v) with npm $(npm -v)"
npm install -g yarn
log "- √ yarn version is $(yarn -v)"

log 'Disable SELinux:'
sed -i -e "s/^SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
log "- √ done"

log 'Disable SSH Password Authentication:'
sed -i -e "s/^PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
log "- √ done"

log "Enable port 80 & 443 for public:"
systemctl start firewalld
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
log "- √ done"

exit 0
