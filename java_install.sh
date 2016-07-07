#!/bin/bash

machine=$(uname -m)

if [ $machine = "x86_64" ];then
	arch="amd64"
else
	arch="i386"
fi

# java:

if [ $arch = "amd64" ];then
	java_arch="x64"
else
	java_arch="i586"
fi

downloads_page='http://www.oracle.com'$(curl -i -X GET http://www.oracle.com/technetwork/java/javase/downloads/index.html 2>/dev/null | sed -n 's/.*href="\([^"]*\).*/\1/p' | grep jdk8-downloads)
download_link=$(curl -i -X GET $downloads_page 2>/dev/null | grep -E 'linux-'$java_arch'.tar.gz' | cut -d":" -f4,5 | cut -d'"' -f2 | tail -1)

ver_major=$(echo $download_link | cut -d"/" -f7 | cut -d"u" -f1)
ver_minor=$(echo $download_link | cut -d"/" -f7 | cut -d"u" -f2 | cut -d"-" -f1)

curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k $download_link

tar xvzf jdk-$ver_major'u'$ver_minor-linux-$java_arch.tar.gz
rm jdk-$ver_major'u'$ver_minor-linux-$java_arch.tar.gz
mv jdk1.$ver_major.0_$ver_minor /opt/
cd /opt/jdk1.$ver_major.0_$ver_minor

update-alternatives --install /usr/bin/java java /opt/jdk1.$ver_major.0_$ver_minor/bin/java 1
update-alternatives --install /usr/bin/javac javac /opt/jdk1.$ver_major.0_$ver_minor/bin/javac 1
update-alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so mozilla-javaplugin.so /opt/jdk1.$ver_major.0_$ver_minor/jre/lib/$arch/libnpjp2.so 1
update-alternatives --set java /opt/jdk1.$ver_major.0_$ver_minor/bin/java
update-alternatives --set javac /opt/jdk1.$ver_major.0_$ver_minor/bin/javac
update-alternatives --set mozilla-javaplugin.so /opt/jdk1.$ver_major.0_$ver_minor/jre/lib/$arch/libnpjp2.so

exit 0