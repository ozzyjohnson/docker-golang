# A slightly simplified version of library/golang which
# can be found here.
#
# https://registry.hub.docker.com/u/library/golang/

FROM debian:wheezy

MAINTAINER Oswald Johnson <oswald.johnson@gsa.gov>

ENV DEBIAN_FRONTEND noninteractive

ENV GOLANG_VERSION 1.4

RUN \
    apt-get update \
        --quiet \
    && apt-get install \
        --yes \
        --no-install-recommends \
        --no-install-suggests \
    ca-certificates \
    curl \
    gcc \ 
    git \
    libc6-dev \
    make \

# Clean up packages.
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sSL \
      https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz \
      | tar -C /usr/src -xz 

RUN cd /usr/src/go/src && \
      ./make.bash --no-clean 2>&1

ENV PATH /usr/src/go/bin:$PATH

RUN mkdir -p /go/src
ENV GOPATH /go
ENV PATH /go/bin:$PATH
