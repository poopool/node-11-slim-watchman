FROM node:11-slim

MAINTAINER Pouya Na <pouya.naghizadeh@gmail.com>

RUN apt-get update && apt-get install -y git make g++ autoconf pkg-config libtool libssl-dev fastjar && \
    rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/facebook/watchman.git /tmp/watchman-src && \
    cd /tmp/watchman-src && \
    git checkout v4.9.0 && \
    ./autogen.sh && \
    ./configure --enable-statedir=/tmp --without-python --without-pcre && \
    make && \
    make install && \
    apt-get purge -y git make pkg-config g++ autoconf libtool libssl-dev && \
    apt-get -y autoremove && \
    rm -rf /tmp/watchman-src
