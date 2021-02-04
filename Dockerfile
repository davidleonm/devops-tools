FROM python:3.9.0-alpine
LABEL maintainer="David Leon <david.leon.m@gmail.com>"

# Install needed libraries
RUN apk add --no-cache \
    openssh \
    openjdk8 \
    git \
    py3-virtualenv \
    curl \
    docker \
    postgresql-dev \
    gcc \
    python3-dev \
    musl-dev \
    make

# Copy needed files to build arm images
COPY qemu-arm-static /usr/bin/qemu-arm-static 

# Copy configuration for sshd
COPY sshd_config /etc/ssh/sshd_config

# Jenkins user creation and assign to necessary groups
RUN adduser -D -h /home/jenkins jenkins -s /bin/ash
RUN echo "jenkins:jenkins" | chpasswd
RUN addgroup jenkins docker
RUN addgroup jenkins ping

# Add authorized keys for Jenkins user
COPY jenkins_key.pub /home/jenkins/.ssh/authorized_keys

# Create hosts keys
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key

# Configure port for ssh connections
EXPOSE 2233

# Start sshd
CMD ["/usr/sbin/sshd", "-D"]
