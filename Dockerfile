FROM ubuntu

MAINTAINER Palominha "https://github.com/palominhadev/kivy-build-generator"

RUN apt update && apt install -y \
    sudo \
    zip \
    unzip \
    openjdk-17-jdk \
    autoconf \
    libtool \
    pkg-config \
    zlib1g-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libtinfo5 \
    cmake \
    libffi-dev \
    libssl-dev \
    python3.10 \
    python3-pip \
    python3-virtualenv \
    python3-setuptools \
    curl \
    git \
    pkg-config \
    automake \
    build-essential \
    adb \
    patch

# environment variables required for user creation.

ENV USER="buildozer"

ENV WORK_DIR="/home/app"

ENV PATH=/home/$USER/.local/bin:$PATH

ADD demo ${WORK_DIR}/demo

RUN adduser ${USER} --disabled-password --disabled-login \
    && chown -R ${USER}:${USER} ${WORK_DIR} \
    && usermod -append --groups sudo ${USER} && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER ${USER}

RUN python3 -m pip install --upgrade pip --user && \
    python3 -m pip install buildozer cython \
    virtualenv python-for-android kivy kivymd

# clears all temp files and apt's cache.

RUN sudo apt autoremove -y \
    && sudo apt clean \
    && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ${WORK_DIR}

WORKDIR ${WORK_DIR}
