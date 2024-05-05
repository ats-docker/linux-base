# Dockerfile
# syntax=docker/dockerfile:1

FROM ubuntu:jammy

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

ARG MAVEN_VERSION="3.9.6"
ARG MAVEN_DOWNLOAD="https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" 

RUN curl -o /tmp/maven.tar.gz ${MAVEN_DOWNLOAD} \
    && tar -xzvf /tmp/maven.tar.gz -C /opt \
    && mv /opt/apache-maven-${MAVEN_VERSION} /opt/maven 
	
ARG JDK_VERSION="21.0.2"
ARG JDK_DOWNLOAD="https://download.java.net/java/GA/jdk21.0.2/f2283984656d49d69e91c558476027ac/13/GPL/openjdk-21.0.2_linux-x64_bin.tar.gz"
	
RUN cd /tmp \
    && curl -o openjdk-${JDK_VERSION}_linux-x64_bin.tar.gz ${JDK_DOWNLOAD} \
    && tar -xzvf openjdk-${JDK_VERSION}_linux-x64_bin.tar.gz \
    && mv jdk-${JDK_VERSION} /usr/bin 

#RUN deluser --remove-home ubuntu 
RUN  rm -rf /tmp/* \
  && apt-get autoremove \
  && apt-get clean 

# Define env variables for Java

ENV JAVA_HOME /usr/bin/jdk-${JDK_VERSION}
ENV JAVA_VERSION ${JDK_VERSION}
ENV M2_HOME /opt/maven
ENV MAVEN_HOME /opt/maven
ENV PATH $JAVA_HOME/bin:${M2_HOME}/bin:$PATH
ENV DOCKER=true
