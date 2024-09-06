FROM fedora:latest

RUN dnf update -y
RUN dnf install -y wget file sudo

RUN wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage \
    -O /usr/local/bin/linuxdeploy-appimage
RUN chmod +x /usr/local/bin/linuxdeploy-appimage

COPY linuxdeploy /usr/local/bin
RUN chmod +x /usr/local/bin/linuxdeploy

ENV USERNAME=builder

RUN groupadd sudo
RUN useradd -ms /bin/bash $USERNAME
RUN usermod -aG sudo $USERNAME
RUN echo "$USERNAME ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USERNAME

USER $USERNAME

WORKDIR /builder

RUN sudo chown -R $USERNAME:$USERNAME /builder
