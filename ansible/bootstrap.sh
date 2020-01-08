#!/bin/bash

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
    #sudo apt-get install -y python-jmespath

	sudo apt-get install -y software-properties-common
	sudo apt-add-repository --yes --update ppa:ansible/ansible || exit 1
	sudo apt-get install --yes ansible || exit 1
    # sudo pip install pywinrm || exit 1
fi

mkdir -p ~/.ansible

if [ ! -f ~/.ansible/bootstrap.pwd ]; then
    touch ~/.ansible/bootstrap.pwd
    chmod 0600 ~/.ansible/bootstrap.pwd
    read -sp 'Vault password: ' password
    echo $password > ~/.ansible/bootstrap.pwd
fi

REQ=requirements/$HOST.yml
echo $REQ

if [ -f $REQ ]; then
    ansible-galaxy install -r $REQ
fi

ANSIBLE_CONFIG=ansible.cfg ansible-playbook --vault-password-file=~/.ansible/bootstrap.pwd --limit $HOST $* site.yml

