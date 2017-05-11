# 2016-Oct-12
# Fedora Latest (24 at this time)
# This is just my basic Fedora Image, with whatever I think should come with an ootb install
# I'll use this to build a fresh fedora image with a GUI, whenever I feel I need a new one

FROM fedora

USER root

# Set root password, so I know it for the future
RUN echo "root:password123" | chpasswd

# Install Java, Open SSL, etc.
RUN dnf update -y --setopt=deltarpm=false  \
 && dnf install -y --setopt=deltarpm=false \
                openssl.x86_64             \
                java-1.8.0-openjdk.x86_64  \
                xorg-x11-server-Xvfb       \
                x11vnc                     \
                firefox                    \
                @xfce-desktop-environment  \
 && dnf clean all

# Create developer user (password: password123, uid: 11111)
RUN useradd -u 11111 -g users -d /home/developer -s /bin/bash -p $(echo password123 | openssl passwd -1 -stdin) developer

# Copy startup script over to the developer home
COPY start-vnc.sh /home/developer/start-vnc.sh
RUN chmod 700 /home/developer/start-vnc.sh
RUN chown developer.users /home/developer/start-vnc.sh

# Expose VNC, SSH
EXPOSE 5901 22

# Set up VNC Password and DisplayEnvVar to point to Display1Screen0
USER developer
ENV  DISPLAY :1.0
RUN  mkdir ~/.x11vnc
RUN  x11vnc -storepasswd letmein ~/.x11vnc/passwd

WORKDIR /home/developer
CMD ["/home/developer/start-vnc.sh"]
