# This is just my minimal stripped down linux base image
# No X, just Alpine, a JRE, and some tools
# BUILD:
#   docker build -t you/alpine-min .
# RUN:
#   docker run -u 0 -it --rm -P you/alpine-min
#
# Just find out the host port that 22 has been exposed onto, and ssh in with:
#   ssh developer@localhost -p 32774   (32774 as an example)
# you can find out what port 22 is exposed as via docker ps, OR docker port containerName 22

FROM alpine

USER root

# Install useful things
RUN apk --update add openjdk8-jre \
                     bash         \
                     tar          \
                     git          \
                     openssh      \
                     openssl      \
                     sudo

# Install Openshift Origin Client
#
# RUN mkdir /opt && \
#     mkdir /opt/oc && \
#     cd /opt && \
#     wget -O- https://s3.amazonaws.com/oso-preview-docker-registry/client-tools/3.3/oc-3.3.0.31-linux.tar.gz | tar xvz -C /opt/oc


# Set root password, so I know it for the future
RUN echo "root:password123" | chpasswd

# Create developer user (password: password123, uid: 11111)
# note Alpine users 'adduser' rather than 'useradd'
# RUN useradd -u 11111 -g users -d /home/developer -s /bin/bash -p $(echo password123 | openssl passwd -1 -stdin) developer
# RUN addgroup users && adduser -u 11111 -G users -h /home/developer -s /bin/bash developer
RUN adduser -u 11111 -G users -h /home/developer -s /bin/bash -D developer
RUN echo "developer:password123" | chpasswd
RUN echo "developer ALL=(ALL) ALL" >> /etc/sudoers

# I want sshd to be running (yes, this is bad practice)
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
# For some reason the apk install of openssh does not generate the host keys, so I have to do this manually
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''
RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
RUN ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ''

COPY start-sshd.sh /root/start-sshd.sh
RUN chmod 700 /root/start-sshd.sh
RUN chown root.root /root/start-sshd.sh

EXPOSE 22
EXPOSE 8080
EXPOSE 8081
EXPOSE 4040

# USER developer
CMD ["/root/start-sshd.sh"]
