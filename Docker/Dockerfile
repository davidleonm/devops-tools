FROM python:3.7.3-alpine3.9
MAINTAINER David Leon <david.leon.m@gmail.com>

# Update packages and install openssh-server and java
RUN apk update && \
    apk add openssh && \
    apk fetch openjdk8 && \
    apk add openjdk8

# ENV Variables
ENV JAVA_HOME /usr

# Clean apk cache
RUN rm -rf /var/cache/apk/*

# Copy configuration for sshd
COPY sshd_config /etc/ssh/sshd_config

# Jenkins user creation
RUN adduser -D -h /home/jenkins jenkins -s /bin/ash
RUN echo "jenkins:jenkins" | chpasswd

# Add authorized keys for Jenkins user
COPY jenkins_key.pub /home/jenkins/.ssh/authorized_keys

# Create hosts keys
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key

# Configured port for ssh connections
EXPOSE 2222

# Start sshd
CMD ["/usr/sbin/sshd", "-D"]