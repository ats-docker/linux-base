# Dockerfile
# syntax=docker/dockerfile:1

FROM ubuntu:jammy
ARG MAVEN_VERSION="3.9.3"
ARG JDK_VERSION="19.0.2"

ARG MAVEN_DOWNLOAD="https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" 
ARG JDK_DOWNLOAD="https://download.java.net/java/GA/jdk${JDK_VERSION}/fdb695a9d9064ad6b064dc6df578380c/7/GPL/openjdk-${JDK_VERSION}_linux-x64_bin.tar.gz"

RUN apt-get update && apt-get install -y wget libfreetype6 git curl bzip2 zip unzip \
    && apt-get install -y --no-install-recommends nvi \
    && cd /tmp \
    && wget ${JDK_DOWNLOAD} \
    && tar -xzvf openjdk-${JDK_VERSION}_linux-x64_bin.tar.gz \
    && mv jdk-${JDK_VERSION} /usr/bin \
    && wget -O /tmp/maven.tar.gz ${MAVEN_DOWNLOAD} \
    && tar -xzvf /tmp/maven.tar.gz -C /opt \
    && mv /opt/apache-maven-${MAVEN_VERSION} /opt/maven \
    && useradd -m ats-user  \
    && rm -rf /tmp/* \
    && apt-get autoremove \
    && apt-get clean 

# Define env variables for Java

ENV JAVA_HOME /usr/bin/jdk-${JDK_VERSION}
ENV M2_HOME /opt/maven
ENV MAVEN_HOME /opt/maven
ENV PATH $JAVA_HOME/bin:${M2_HOME}/bin:$PATH
ENV DOCKER=true
