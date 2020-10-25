#!/bin/bash

sudo apt-get remove mongodb-org-server mongodb-org-shell
# 4.0
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
# 4.4
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 20691eec35216c63caf66ce1656408e390cfb1f5

if [ "$MONGODB" = "4.0" ]; then
    echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb.list
    sudo apt-get update
    sudo apt-get install mongodb-org-server=4.0.9 mongodb-org-shell=4.0.9
elif [ "$MONGODB" = "4.4" ]; then
    echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb.list
    sudo apt-get update
    sudo apt-get install mongodb-org-server=4.4.1 mongodb-org-shell=4.4.1
else
    echo "Invalid MongoDB version"
    exit 1
fi;

mkdir db
1>db/logs mongod --dbpath=db &
