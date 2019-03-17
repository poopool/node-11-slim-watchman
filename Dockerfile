FROM node:11-slim

MAINTAINER Pouya Na <pouya.naghizadeh@gmail.com>

#Installing Watchman
RUN apt-get update && apt-get install -y git make g++ autoconf pkg-config libtool libssl-dev && \
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

#Installing gcloud-sdk
RUN apt-get update && apt-get install -y lsb-release && \
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install google-cloud-sdk -y && \
    rm -rf /var/lib/apt/lists/* && apt-get purge -y lsb-release && apt-get -y autoremove
