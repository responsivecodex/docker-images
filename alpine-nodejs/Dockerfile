##############################################################################
#  Provide a development environment on NodeJS using last versions at today
##############################################################################
FROM responsivecodex/alpine-nodejs:latest                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           

RUN USER=root  npm --force --cache /tmp/empty-cache install -g \
  typescript \
  @angular/cli 

RUN npm --force cache clean 

# Always and for all projects my working folder is..


# Always and for all projects my working folder is..
WORKDIR /usr/src                                   

# My application on NodeJS listen this port (on dev-env)
EXPOSE 3000                                             

# Always must execute this shell to enable redirection of traffic to real world....
# https://responsivecodex.wordpress.com
#ENTRYPOINT ["/bin/ash","forwardip.sh"]         


# Supressed because don't exists the file.
# RUN chmod 0755 /etc/sysctl.d/ipv4.conf


RUN mkdir /usr/scripts 
COPY forwardip.sh /usr/scripts/forwardip.sh
RUN chmod +x /usr/scripts/forwardip.sh


ENTRYPOINT ["/bin/ash"] 

# CMD ["/usr/scripts/forwardip.sh"]