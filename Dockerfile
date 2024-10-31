# Dockerfile
# syntax=docker/dockerfile:1

FROM ubuntu:24.10

RUN apt-get update
RUN apt-get install -y --no-install-recommends nvi
RUN apt-get install -y \
  sudo \
  build-essential \
  libfreetype6 \
  xserver-xorg-core \
  xvfb \
  git \
  curl \
  bzip2 \
  zip \
  gpg \
  gnupg \
  libdbus-glib-1-2 \
  psmisc \
  iproute2 \
  libssl-dev \
  imagemagick \
  wget \
  unzip \
  fontconfig \
  locales \
  libatk1.0-0 \
  libc6 \
  libcairo2 \
  libcups2 \
  libdbus-1-3 \
  libexpat1 \
  libfontconfig1 \
  libgcc1 \
  libgdk-pixbuf2.0-0 \
  libglib2.0-0 \
  libgtk-3-0 \
  libnspr4 \
  libpango-1.0-0 \
  libpangocairo-1.0-0 \
  libstdc++6 \
  libx11-6 \
  libx11-xcb1 \
  libxcb1 \
  libxcomposite1 \
  libxcursor1 \
  libxdamage1 \
  libxext6 \
  libxfixes3 \
  libxi6 \
  libxrandr2 \
  libxrender1 \
  libxss1 \
  libxtst6 \
  ca-certificates \
  fonts-liberation \
  libnss3 \
  lsb-release \
  xdg-utils \
  libx11-xcb-dev \
  libatk-bridge2.0-0 && \
  rm -rf /var/lib/apt/lists/*
  
RUN  rm -rf /tmp/* \
  && apt-get -y autoremove \
  && apt-get -y clean 
  
RUN mkdir -pv ~/.cache/xdgr
ENV XDG_RUNTIME_DIR=$PATH:~/.cache/xdgr

ENV DOCKER=true
ENV X11_ENABLED=true

ENV ATS_USER=ats-user
ENV ATS_GROUP=ats-group
ENV ATS_USER_HOME=/home/${ATS_USER}/
#RUN mkdir -p ${ATS_USER_HOME}

RUN groupadd -r -g 1001 ${ATS_GROUP} && \
		useradd -m $ATS_USER && \
        echo "$ATS_USER:$ATS_GROUP" | chpasswd && \
        usermod --shell /bin/bash $ATS_USER && \
        usermod  --uid 1001 $ATS_USER && \
        groupmod --gid 1001 $ATS_GROUP

#RUN groupadd -r -g 1001 ${ATS_GROUP} && useradd --no-log-init -r -u 1001 -g ${ATS_GROUP} ${ATS_USER}

#-----------------------------------------------------------------------------------------------------------------------------------------------------
ARG JDK_VERSION="21.0.2"
ENV JAVA_VERSION=${JDK_VERSION}
ENV JAVA_HOME=/usr/bin/jdk
#-----------------------------------------------------------------------------------------------------------------------------------------------------
ARG JDK_DOWNLOAD="https://download.java.net/java/GA/jdk21.0.2/f2283984656d49d69e91c558476027ac/13/GPL/openjdk-21.0.2_linux-x64_bin.tar.gz"
	
RUN cd /tmp \
    && curl -o openjdk-${JDK_VERSION}_linux-x64_bin.tar.gz ${JDK_DOWNLOAD} \
    && tar -xzvf openjdk-${JDK_VERSION}_linux-x64_bin.tar.gz \
    && mv jdk-${JDK_VERSION} /usr/bin 
	
RUN ln -s /usr/bin/jdk-${JDK_VERSION} ${JAVA_HOME}
#-----------------------------------------------------------------------------------------------------------------------------------------------------

ENV PATH=$JAVA_HOME/bin:$PATH

#-----------------------------------------------------------------------------------------------------------------------------------------------------
