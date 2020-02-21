#!/bin/bash

if [[ ! `which git` ]]; then
    sudo apt-get install -y git
fi

if [[ ! -d bootstrap-pc ]]; then
    git clone https://github.com/rsvanda/bootstrap-pc.git
fi

