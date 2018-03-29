FROM debian:latest

ARG ssh_pub_key

RUN apt-get update
RUN apt-get install -y git openssh-server python python-pip vim libldap2-dev libsasl2-dev

RUN pip install virtualenv ansible debops

RUN debops-update


# Authorize SSH Host
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    mkdir -p /var/run/sshd

# Add the keys and set permissions
RUN echo "$ssh_pub_key" > /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/authorized_keys

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
