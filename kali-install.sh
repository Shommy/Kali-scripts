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

downloads_page='http://www.oracle.com'$(curl -i -X GET http://www.oracle.com/technetwork/java/javase/downloads/index.html 2>/dev/null | sed -n 's/.*href="\([^"]*\).*/\1/p' | grep jdk8-downloads)
download_link=$(curl -i -X GET $downloads_page 2>/dev/null | grep 'linux-x64.tar.gz' | cut -d":" -f4,5 | cut -d'"' -f2 | tail -1)

ver_major=$(echo $download_link | cut -d"/" -f7 | cut -d"u" -f1)
ver_minor=$(echo $download_link | cut -d"/" -f7 | cut -d"u" -f2 | cut -d"-" -f1)

curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k $download_link

tar xvzf jdk-$ver_major'u'$ver_minor-linux-x64.tar.gz
rm jdk-$ver_major'u'$ver_minor-linux-x64.tar.gz
mv jdk1.$ver_major.0_$ver_minor /opt/
cd /opt/jdk1.$ver_major.0_$ver_minor

update-alternatives --install /usr/bin/java java /opt/jdk1.$ver_major.0_$ver_minor/bin/java 1
update-alternatives --install /usr/bin/javac javac /opt/jdk1.$ver_major.0_$ver_minor/bin/javac 1
update-alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so mozilla-javaplugin.so /opt/jdk1.$ver_major.0_$ver_minor/jre/lib/amd64/libnpjp2.so 1
update-alternatives --set java /opt/jdk1.$ver_major.0_$ver_minor/bin/java
update-alternatives --set javac /opt/jdk1.$ver_major.0_$ver_minor/bin/javac
update-alternatives --set mozilla-javaplugin.so /opt/jdk1.$ver_major.0_$ver_minor/jre/lib/amd64/libnpjp2.so

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

# netscan (windows tool) --> has some issues, throws exceptions

wget https://www.softperfect.com/download/freeware/netscan.zip
mkdir /opt/netscan/
mv netscan.zip /opt/netscan/
cd /opt/netscan/
unzip netscan.zip
rm netscan.zip
echo "#!/bin/bash" > /opt/netscan/netscan_run.sh
echo >> /opt/netscan/netscan_run.sh
echo "wine /opt/netscan/32-bit/netscan.exe &" >> /opt/netscan/netscan_run.sh
echo >> /opt/netscan/netscan_run.sh
chmod +x /opt/netscan/netscan_run.sh
ln -s /opt/netscan/netscan_run.sh /usr/bin/netscan

# ApacheDirectoryStudio - LDAP browser

ads_download_link=$(curl -i -k -X GET https://directory.apache.org/studio/download/download-linux.html 2>/dev/null | sed -n 's/.*href="\([^"]*\).*/\1/p' | grep -E 'x86_64.tar.gz$' | head -1)
ads_file_name=$(echo $ads_download_link | awk -F"/" '{ print $NF }')
wget $ads_download_link
tar xvfz $ads_file_name
mv ApacheDirectoryStudio /opt/
rm $ads_file_name
ln -s /opt/ApacheDirectoryStudio/ApacheDirectoryStudio /usr/bin/ApacheDirectoryStudio



# TODO: gnome screenshot shortcut and other gnome tweaks, vmware tools, terminal and text editor preferences, ...

