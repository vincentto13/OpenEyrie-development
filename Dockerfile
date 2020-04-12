FROM ubuntu:18.04

RUN apt-get remove --purge --auto-remove g++
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:jonathonf/gcc-9.0 -y
RUN apt-get update && apt-get install -y dbus systemd python3 python3-pip vim wget git autoconf libsystemd-dev
RUN apt-get install -y gcc-9
RUN apt-get install -y g++-9
RUN pip3 install conan

RUN mkdir /tmp/cmake
WORKDIR /tmp/cmake
RUN mkdir -p /opt/cmake
RUN wget https://cmake.org/files/v3.17/cmake-3.17.0-Linux-x86_64.sh
RUN sh cmake-3.17.0-Linux-x86_64.sh --prefix=/opt/cmake --skip-license
RUN ln -s /opt/cmake/bin/cmake /usr/bin/cmake

COPY . /
RUN chmod 770 /etc/init/run.sh

RUN mkdir -p /root/workspace
WORKDIR /root/workspace
