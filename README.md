This is a customized [ansible](https://www.ansible.com/) tool that helps you for provisioning. (Expects CentOS/RHEL 7.x hosts)
It will set up the following infrastructures by one command:
1. Pre Init System: Set hostname, disable SElinux, install EPEL, disable SSH password Authentication, install NodeJS, enable portal 80 & 443
2. Install MariaDB
3. Install Nginx and setup CertBot
4. Create user deploy (with same ssh authorized_keys with root), also prepare the '/apps' folder (owned by deploy)
5. Install Ruby with RVM (by deploy)

## Usage
1. Add your hosts to `hosts`
2. Make sure you have SSH access of 'root' to the deploy servers
3. Modify the vars inside the `play_deploy.yml`
4. `ansible-playbook play_provisioning.yml`

You can start a new terminal to tail the setup log over SSH while you running the `ansible-playbook`, then you can get the runtime log:
`ssh root@remote_host "touch /tmp/setup.log && tail -f /tmp/setup.log"`

