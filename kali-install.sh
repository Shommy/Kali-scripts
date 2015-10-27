#!/bin/bash

# Author: Milos Celic
# Twitter: @L05hMee
# This script will grow over time :)

# update:

apt-get update
apt-get upgrade -y

# useful tools from repos:

apt-get install gcc g++ make python3 htop vpnc openconnect gimp filezilla gedit ipcalc samba tor ghex terminator curl build-essential linux-headers-amd64 rar unrar p7zip p7zip-full zip unzip ssh zsh

# msf:

update-rc.d postgresql enable
service postgresql start
msfdb init
msfconsole -r init.rc

# java:

curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-x64.tar.gz
tar xvzf jdk-8u66-linux-x64.tar.gz
rm jdk-8u66-linux-x64.tar.gz
mv jdk1.8.0_66 /opt/
cd /opt/jdk1.8.0_66
update-alternatives --install /usr/bin/java java /opt/jdk1.8.0_66/bin/java 1
update-alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_66/bin/javac 1
update-alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so mozilla-javaplugin.so /opt/jdk1.8.0_66/jre/lib/amd64/libnpjp2.so 1
update-alternatives --set java /opt/jdk1.8.0_66/bin/java
update-alternatives --set javac /opt/jdk1.8.0_66/bin/javac
update-alternatives --set mozilla-javaplugin.so /opt/jdk1.8.0_66/jre/lib/amd64/libnpjp2.so

# veil-evasion:

git clone https://github.com/Veil-Framework/Veil-Evasion.git /opt/Veil-Evasion
cd /opt/Veil-Evasion/setup
/opt/Veil-Evasion/setup/setup.sh
ln -s /opt/Veil-Evasion/Veil-Evasion.py /usr/bin/veil-evasion

# empire:

git clone https://github.com/PowerShellEmpire/Empire.git /opt/Empire
cd /opt/Empire/setup
/opt/Empire/setup/install.sh

# testssl.sh:

git clone https://github.com/drwetter/testssl.sh.git /opt/testssl.sh
ln -s /opt/testssl.sh/testssl.sh /usr/bin/testssl.sh

# Responder:

git clone https://github.com/SpiderLabs/Responder.git /opt/Responder
rm /usr/bin/responder
ln -s /opt/Responder/Responder.py /usr/bin/responder

# Discover:

git clone https://github.com/leebaird/discover.git /opt/Discover
cd /opt/Discover
./update.sh
ln -s /opt/Discover/discover.sh /usr/bin/discover

# Backdoor Factory:

git clone https://github.com/secretsquirrel/the-backdoor-factory /opt/the-backdoor-factory
cd /opt/the-backdoor-factory
./install.sh


# CMSmap:

git clone https://github.com/Dionach/CMSmap.git /opt/CMSmap
ln -s /opt/CMSmap/cmsmap.py /usr/bin/cmsmap

# NoSqlMap:

git clone https://github.com/tcstool/NoSQLMap.git /opt/NoSQLMap
cd /opt/NoSQLMap/
python setup.py install
ln -s /opt/NoSQLMap/nosqlmap.py /usr/bin/nosqlmap

# nishang

git clone https://github.com/samratashok/nishang /opt/nishang



# TODO: gnome screenshot shortcut and other gnome tweaks, vmware tools, terminal and text editor preferences, ...

