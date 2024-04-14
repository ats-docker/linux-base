# Dockerfile
# syntax=docker/dockerfile:1

FROM ubuntu:lunar
ARG MAVEN_VERSION="3.9.6"
ARG JDK_VERSION="22"

ARG MAVEN_DOWNLOAD="https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" 
#ARG JDK_DOWNLOAD="https://download.java.net/java/GA/jdk${JDK_VERSION}/b4887098932d415489976708ad6d1a4b/9/GPL/openjdk-${JDK_VERSION}_linux-x64_bin.tar.gz"	  
ARG JDK_DOWNLOAD="https://download.java.net/java/GA/jdk${JDK_VERSION}/415e3f918a1f4062a0074a2794853d0d/12/GPL/openjdk-${JDK_VERSION}_linux-x64_bin.tar.gz"	  

RUN apt-get update  
RUN apt-get install -y libfreetype6 
RUN apt-get install -y git 
RUN apt-get install -y curl 
RUN apt-get install -y bzip2 
RUN apt-get install -y zip
RUN apt-get install -y unzip 
RUN apt-get install -y --no-install-recommends nvi
RUN apt-get install -y psmisc
RUN apt-get install -y iproute2 
RUN cd /tmp \
    && curl -o openjdk-${JDK_VERSION}_linux-x64_bin.tar.gz ${JDK_DOWNLOAD} \
    && tar -xzvf openjdk-${JDK_VERSION}_linux-x64_bin.tar.gz \
    && mv jdk-${JDK_VERSION} /usr/bin 
RUN curl -o /tmp/maven.tar.gz ${MAVEN_DOWNLOAD} \
    && tar -xzvf /tmp/maven.tar.gz -C /opt \
    && mv /opt/apache-maven-${MAVEN_VERSION} /opt/maven 

RUN deluser --remove-home ubuntu 
RUN  useradd -m ats-user  \
  && rm -rf /tmp/* \
  && apt-get autoremove \
  && apt-get clean 

# Define env variables for Java

ENV JAVA_HOME /usr/bin/jdk-${JDK_VERSION}
ENV M2_HOME /opt/maven
ENV MAVEN_HOME /opt/maven
ENV PATH $JAVA_HOME/bin:${M2_HOME}/bin:$PATH
ENV DOCKER=true
