#!/bin/bash

# Enable ability to see commands we're executing
set -eux

apt-get update
apt-get install -y --no-install-recommends \
	autoconf \
	automake \
	libtool \
	make \
	libgnutls28-dev \
	libjson-glib-dev \
	libotr5-dev \
	libpurple-dev \
	git \
	libprotobuf-c-dev \
	protobuf-c-compiler

cd /tmp

## bitlbee
git clone https://github.com/bitlbee/bitlbee.git
cd /tmp/bitlbee
git checkout $BITLBEE_VERSION
./configure --jabber=1 --otr=1 --purple=1
make
make install
make install-dev

## skypeweb
cd /tmp
git clone https://github.com/EionRobb/skype4pidgin.git
cd /tmp/skype4pidgin/skypeweb
make
make install

## bitlbee-facebook
cd /tmp
git clone https://github.com/bitlbee/bitlbee-facebook.git
cd /tmp/bitlbee-facebook
./autogen.sh
make
make install
# libtool --finish
./libtool --finish /usr/local/lib/bitlbee


## purple-hangouts
cd /tmp
git clone https://github.com/EionRobb/purple-hangouts.git
cd /tmp/purple-hangouts
make
make install

## cleanup
apt-get autoremove -y --purge \
	autoconf \
	automake \
	libtool \
	make \
	protobuf-c-compiler
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
rm -fr /root/build.sh

# add user bitlbee
adduser --system --home /var/lib/bitlbee \
	--disabled-password --disabled-login \
	--shell /usr/sbin/nologin bitlbee
touch /var/run/bitlbee.pid && chown bitlbee:nogroup /var/run/bitlbee.pid
