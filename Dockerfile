############################################################
# Dockerfile to build Python 3 Application Containers
# Based on Ubuntu
############################################################

FROM ubuntu:18.04
MAINTAINER Serhii Zahranychnyi <serhii.z@edicasoft.com>

# Setup environment
ENV DEBIAN_FRONTEND noninteractive

# replace default command interpreter to `bash` to be able to use `source`
RUN ln -snf /bin/bash /bin/sh

# Update sources
RUN apt-get update -y

# Install basic applications
RUN apt-get install -y tar git curl mc wget dialog net-tools build-essential \
        apt-transport-https \
        ca-certificates \
        libssl-dev

# Install python3
RUN apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -sf /usr/bin/python3 python \
  && ln -sf /usr/bin/pip3 pip

RUN pip install --upgrade pip

# Instal project dependencies
RUN apt-get install -y libmemcached-dev \
  && rm -rf /var/lib/apt/lists/*


# Install project pip requirements
ADD requirements/base.txt /app/
RUN cd /app \
  && pip install -U -r base.txt

EXPOSE 8000

WORKDIR /app
CMD "/bin/bash"

