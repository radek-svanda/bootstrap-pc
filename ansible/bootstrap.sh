#!/bin/bash

if [ ! -f ~/.ssh/id_rsa ]; then
    echo "----- SSH Key is essential, creating a new one"
    ssh-keygen -b 4096 -f ~/.ssh/id_rsa -N ""
    echo "----- Add the key to bitbucket account"
    cat ~/.ssh/id_rsa.pub
    exit
fi

HOST=$1

if [ -z "$HOST" ]; then
    echo "Specify host or a group to provision. Available hosts:"
    echo "----------------------------------------"
    cat hosts.ini | grep '\['
    echo "----------------------------------------"
    exit 2
fi

shift

if [ ! -f /usr/bin/ansible ]; then
    echo "Installing ansible"
    sudo apt-get update --yes

    #sudo apt-get install -y python-pip --no-install-recommends
    sudo apt-get install -y python-jmespath python-psutil || exit 1

	sudo apt-get install -y software-properties-common
	sudo apt-add-repository --yes --update ppa:ansible/ansible || exit 1
	sudo apt-get install --yes ansible || exit 1
    # sudo pip install pywinrm || exit 1
fi

mkdir -p ~/.ansible

bootstrap_pwd_file=~/.ansible/bootstrap.pwd
if [[ ! -f ${bootstrap_pwd_file} ]]; then
    touch ${bootstrap_pwd_file}
    chmod 0600 ${bootstrap_pwd_file}
    read -sp 'Vault password: ' password
    echo $password > ${bootstrap_pwd_file}
    echo 'OK'
fi

become_pwd_file=~/.ansible/become.pwd
if [[ ! -f ${become_pwd_file} ]]; then
    touch ${become_pwd_file}
    chmod 0600 ${become_pwd_file}
    read -sp 'Become password: ' password
    echo $password > ${become_pwd_file}
    echo 'OK'
fi


REQ=requirements/$HOST.yml
echo $REQ

if [ -f $REQ ]; then
    ansible-galaxy install -r $REQ
fi


if [[ ! -f secrets.yml ]]; then
    cp secrets.example.yml secrets.yml
    ansible-vault encrypt --vault-password-file ${bootstrap_pwd_file} secrets.yml
    ansible-vault edit secrets.yml
fi

ANSIBLE_CONFIG=ansible.cfg \
    ansible-playbook \
    --vault-password-file=~/.ansible/bootstrap.pwd \
    --extra-vars "ansible_become_pass=`cat ${become_pwd_file}`" \
    --limit $HOST $* site.yml

