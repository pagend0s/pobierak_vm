#!bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt-get install wget build-essential checkinstall
sudo apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev -y


cd /usr/src
sudo wget https://www.python.org/ftp/python/3.9.9/Python-3.9.9.tgz

sudo tar xzf Python-3.9.9.tgz

cd Python-3.9.9
sudo ./configure --enable-optimizations
sudo make altinstall

sudo echo "alias python='/usr/local/bin/python3.9'" >> ~/.bashrc
