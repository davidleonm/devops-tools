FROM python:3.7.3-alpine3.9
MAINTAINER David Leon <david.leon.m@gmail.com>

RUN apk update && apk add openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:123456' | chpasswd
RUN sed 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' -i /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE 'in users profile'
RUN echo 'export VISIBLE=now' >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]