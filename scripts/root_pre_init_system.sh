#!/usr/bin/env bash

set -e

# Prepare deploy_log command
if ! [ -x "$(command -v deploy_log)" ]; then
sudo cat >/usr/bin/deploy_log <<EOL
#!/usr/bin/env bash
set -xe
LOG_PATH=/deploy.log
if [ \$# -eq 0 ]; then
  cat \$LOG_PATH
else
  echo "\$(date +[\ %Y-%m-%d\ %H:%M:%S\ ]) \$1" >> \$LOG_PATH
fi
EOL
sudo chmod +x /usr/bin/deploy_log

touch  /deploy.log
chmod 666 /deploy.log
fi
deploy_log "-----------------------------------------------------------------------------------------------------"
deploy_log "Linux version: $(uname -a)"

export HOSTNAME=$1
hostname $HOSTNAME
echo $HOSTNAME > /etc/hostname;
deploy_log "Set hostname: $HOSTNAME:"

deploy_log "Install EPEL and update all installed packages"
yum -y install epel-release
yum -y update
deploy_log "- * Install RVM Requirements"
yum -y install autoconf automake bison bzip2 gcc-c++ libffi-devel libtool readline-devel sqlite-devel
yum -y install curl wget git vim
deploy_log "- √ done"

deploy_log "Install NodeJS:"
rpm -ivh https://kojipkgs.fedoraproject.org//packages/http-parser/2.7.1/3.el7/x86_64/http-parser-2.7.1-3.el7.x86_64.rpm && yum -y install nodejs
deploy_log "- √ installed Nodejs $(node -v) with npm $(npm -v)"
npm install -g yarn
deploy_log "- √ yarn version is $(yarn -v)"

deploy_log 'Disable SELinux:'
sed -i -e "s/^SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
deploy_log "- √ done"

deploy_log 'Disable SSH Password Authentication:'
sed -i -e "s/^PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
deploy_log "- √ done"

deploy_log "Enable port 80 & 443 for public:"
systemctl start firewalld
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
deploy_log "- √ done"

exit 0
