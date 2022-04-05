######################################################################################################
#  Provide a development environment on Java-NodeJS-Angular using last versions at today
######################################################################################################


############  This part its because exists a problem with nodejs (on this days)
# https://github.com/nodejs/node/issues/41058
#
FROM alpine:3.15 as libstdc-donor
RUN apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/main libstdc++

FROM postgres:12.4-alpine
COPY --from=libstdc-donor /usr/lib/libstdc++.so.6.0.29 /usr/lib/libstdc++.so.6.0.29

############  When all its OK, its enougth with this:
# FROM alpine:3.15 as alpine-base



# Parse arguments for the build command.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
ARG VERSION=1.0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
ARG VCS_URL=https://hub.docker.com/r/responsivecodex/alpine-java-angular                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
ARG VCS_REF=git rev-parse --short HEAD                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
ARG BUILD_DATE=2021-04-29                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
ARG NODEJS_VERSION=16.14.2-r0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
ARG NPM_VERSION=8.3.0-r0
ARG SUDO_VERSION=1.9.5p2-r0

#define the volumes at run time - far better
#VOLUME ["${SRC_DIR}", "${NODE_APP_DIR}"]


LABEL maintainer=responsivecodex@gmail.com
USER root                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              

ENV LANG C.UTF-8 \
  NODE_APP_DIR=/usr/src \
  NODE_PATH=/usr/lib/node_modules  \
  NPM_CONFIG_SPIN=false  \
  NPM_CONFIG_PROGRESS=false  \
  SRC_DIR=/usr/src                    

RUN rm /usr/lib/libstdc++.so.6 && ln -s /usr/lib/libstdc++.so.6.0.29 /usr/lib/libstdc++.so.6
RUN apk upgrade && \
  apk -UvX http://dl-4.alpinelinux.org/alpine/edge/main add \
  nodejs=${NODEJS_VERSION} \
  npm=${NPM_VERSION}


##############################################################################
#  Long string commands but minimize the size on final image
#
#  Explain line 78-79:  Configure time&date to use location on Mexico City
#  Explain line 78-79:  Create two user: admin & vscode
#    the first was added to responsivecodex group
#    the second was added to users group
#    finally grant others permission as normal users.
##############################################################################


RUN apk update && \
  apk add --update-cache \         
  bash \
  sudo=${SUDO_VERSION} \
  ip6tables \
  iptables \
  tcptraceroute \
  build-base \
  git \
  su-exec \
  python3-dev \
  py-pip \
  gcc && \
  mkdir -p /root/.cache/node-gyp/latest && \
  apk del build-base && \
  rm -rf /tmp /root/.node-gyp && \
  rm -rf /var/cache/apk/* && \
  mkdir -p /tmp && \
  chmod 1777 /tmp && \
  USER=root  rm -rf /etc/localtime && \
  USER=root  ln -s /usr/share/zoneinfo/America/Mexico_City /etc/localtime && \
  echo '%responsivecodex ALL=(ALL) ALL' > /etc/sudoers.d/responsivecodex && \
  addgroup -S responsivecodex && \
  adduser -h /usr/src --disabled-password --shell /bin/ash admin -G responsivecodex && \
  adduser -h /usr/src --disabled-password --shell /bin/ash vscode -G users && \
  for u in $(ls /home); do for g in disk lp floppy audio cdrom dialout video netdev games users; do addgroup $u $g; done;done 


RUN USER=root  npm --force --cache /tmp/empty-cache install -g \
  sass \
  nodemon \          
  express-generator \
  npm-check-updates \
  jsdoc \
  heroku \
  typescript \
  @angular/cli && \
  npm --force cache clean 

# Setting password for recently created users.
RUN  echo admin:#Access2010# | chpasswd && \
  echo vscode:#Access2010# | chpasswd && \
  echo '#!/usr/bin/env ash' > /etc/profile.d/rc.sh && \
  echo "export PS1=\"\e[0;33m[\u@\t \w]-\$ \e[m\"" >> /etc/profile.d/rc.sh  && \
  echo 'export PS1="\e[0;33m[\u@\t \w]\$ \e[m"' >> /root/.ashrc && \
  echo 'export PS1="\e[0;33m[\u@\t \w]\$ \e[m"' >> /root/.bashrc && \
  chmod +x /etc/profile.d/rc.sh && \
  chmod +x /root/.ashrc && \
  chmod +x /root/.bashrc 

#########################################################################################
# https://stackoverflow.com/questions/42513642/installing-java-on-docker-in-docker-image
#
# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
        echo '#!/bin/sh'; \
        echo 'set -e'; \
        echo; \
        echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    } > /usr/local/bin/docker-java-home \
    && chmod +x /usr/local/bin/docker-java-home

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-11-openjdk/jre/bin:/usr/lib/jvm/java-11-openjdk/bin
ENV JAVA_VERSION 11u
ENV JAVA_ALPINE_VERSION 11.0.9_p11-r0

RUN set -x && \
  apk add --no-cache openjdk11 && \
  [ "$JAVA_HOME" = "$(docker-java-home)" ] && \
  apk add --no-cache maven

COPY maven.sh /etc/profile.d
RUN chmod +x /etc/profile.d/maven.sh && \
    source /etc/profile.d/maven.sh



# [root@07171603b344>d16:0716:07 /usr/src]$ 


# My application on NodeJS listen this port (on dev-env)
EXPOSE 3030                                             
# 

# Always and for all projects my working folder is..
WORKDIR /usr/src                                   

RUN mkdir /usr/scripts 
COPY forwardip.sh /usr/scripts/forwardip.sh
RUN chmod +x /usr/scripts/forwardip.sh

ENTRYPOINT ["/bin/ash"] 
