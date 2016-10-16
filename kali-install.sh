#!/bin/bash

# Author: Milos Celic
# Twitter: @L05hMee
# This script will grow over time :)

# 32 or 64-bit

machine=$(uname -m)

if [ $machine = "x86_64"];then
	arch="amd64"
else
	arch="i386"
fi

# update:

echo 
echo "Updating system from the repos"
echo

apt-get update
apt-get upgrade -y

# vmware tools:

echo
echo "Installing vmware tools"
echo 

apt-get install open-vm-tools-desktop fuse

# useful tools from repos:

echo 
echo "Installing some useful tools from the Kali repos"
echo

apt-get install gcc g++ make python3 htop vpnc openconnect gimp filezilla gedit ipcalc samba tor ghex terminator curl build-essential rar unrar p7zip p7zip-full zip unzip ssh zsh

# msf:

echo 
echo "Setting up metasploit database and msfconsole prompt"
echo

update-rc.d postgresql enable
service postgresql start
msfdb init
msfconsole -r init.rc

# java:

echo 
echo "Installing Oracle Java ... "
echo

if [ $arch = "amd64" ];then
	java_arch="x64"
else
	java_arch="i586"
fi

downloads_page='http://www.oracle.com'$(curl -i -X GET http://www.oracle.com/technetwork/java/javase/downloads/index.html 2>/dev/null | sed -n 's/.*href="\([^"]*\).*/\1/p' | grep jdk8-downloads)
download_link=$(curl -i -X GET $downloads_page 2>/dev/null | grep -E 'linux-'$java_arch'.tar.gz' | cut -d":" -f4,5 | cut -d'"' -f2 | tail -1)

ver_major=$(echo $download_link | cut -d"/" -f7 | cut -d"u" -f1)
ver_minor=$(echo $download_link | cut -d"/" -f7 | cut -d"u" -f2 | cut -d"-" -f1)

echo
echo "Downloading JDK installation from the Oracle site"
echo

curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k $download_link

tar xvzf jdk-$ver_major'u'$ver_minor-linux-$java_arch.tar.gz
rm jdk-$ver_major'u'$ver_minor-linux-$java_arch.tar.gz
mv jdk1.$ver_major.0_$ver_minor /opt/
cd /opt/jdk1.$ver_major.0_$ver_minor

echo
echo "Setting up the java paths"
echo

update-alternatives --install /usr/bin/java java /opt/jdk1.$ver_major.0_$ver_minor/bin/java 1
update-alternatives --install /usr/bin/javac javac /opt/jdk1.$ver_major.0_$ver_minor/bin/javac 1
update-alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so mozilla-javaplugin.so /opt/jdk1.$ver_major.0_$ver_minor/jre/lib/$arch/libnpjp2.so 1
update-alternatives --set java /opt/jdk1.$ver_major.0_$ver_minor/bin/java
update-alternatives --set javac /opt/jdk1.$ver_major.0_$ver_minor/bin/javac
update-alternatives --set mozilla-javaplugin.so /opt/jdk1.$ver_major.0_$ver_minor/jre/lib/$arch/libnpjp2.so

# veil-evasion:

echo 
echo "Installing Veil Evasion"
echo

git clone https://github.com/Veil-Framework/Veil-Evasion.git /opt/Veil-Evasion
cd /opt/Veil-Evasion/setup
/opt/Veil-Evasion/setup/setup.sh
ln -s /opt/Veil-Evasion/Veil-Evasion.py /usr/bin/veil-evasion

# empire:

echo 
echo "Installing PowerShellEmpire"
echo

# fix pip issues:
apt-get remove python-pip
easy_install pip

git clone https://github.com/PowerShellEmpire/Empire.git /opt/Empire
cd /opt/Empire/setup
/opt/Empire/setup/install.sh

# testssl.sh:

echo 
echo "Installing testssl.sh"
echo

git clone https://github.com/drwetter/testssl.sh.git /opt/testssl.sh
ln -s /opt/testssl.sh/testssl.sh /usr/bin/testssl.sh

# Responder:

echo 
echo "Installing responder"
echo

git clone https://github.com/SpiderLabs/Responder.git /opt/Responder
rm /usr/bin/responder
ln -s /opt/Responder/Responder.py /usr/bin/responder

# Discover:

echo 
echo "Installing discover"
echo

git clone https://github.com/leebaird/discover.git /opt/Discover
cd /opt/Discover
./update.sh
ln -s /opt/Discover/discover.sh /usr/bin/discover

# Backdoor Factory:

echo 
echo "Installing the-backdoor-factory"
echo

git clone https://github.com/secretsquirrel/the-backdoor-factory /opt/the-backdoor-factory
cd /opt/the-backdoor-factory
./install.sh


# CMSmap:

echo 
echo "Installing CMSmap"
echo

git clone https://github.com/Dionach/CMSmap.git /opt/CMSmap
ln -s /opt/CMSmap/cmsmap.py /usr/bin/cmsmap

# NoSqlMap:

echo 
echo "Installing NoSqlMap"
echo

git clone https://github.com/tcstool/NoSQLMap.git /opt/NoSQLMap
cd /opt/NoSQLMap/
python setup.py install
ln -s /opt/NoSQLMap/nosqlmap.py /usr/bin/nosqlmap

# nishang

echo 
echo "Installing nishang"
echo

git clone https://github.com/samratashok/nishang /opt/nishang

# PowerSploit

echo 
echo "Installing PowerSploit"
echo

git clone https://github.com/PowerShellMafia/PowerSploit.git /opt/PowerSploit


# ApacheDirectoryStudio - LDAP browser

echo 
echo "Installing ApacheDirectoryStudio"
echo

if [ $machine = "x86_64" ];then
	ads_machine=$machine
else
	ads_machine="x86"
fi

ads_download_link=$(curl -i -k -X GET https://directory.apache.org/studio/download/download-linux.html 2>/dev/null | sed -n 's/.*href="\([^"]*\).*/\1/p' | grep -E $ads_arch'.tar.gz$' | head -1)
ads_file_name=$(echo $ads_download_link | awk -F"/" '{ print $NF }')
wget $ads_download_link
tar xvfz $ads_file_name
mv ApacheDirectoryStudio /opt/
rm $ads_file_name
ln -s /opt/ApacheDirectoryStudio/ApacheDirectoryStudio /usr/bin/ApacheDirectoryStudio



# TODO: gnome screenshot shortcut and other gnome tweaks, terminal and text editor preferences, ...

