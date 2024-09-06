FROM fedora:latest

RUN dnf update -y
RUN dnf install -y wget file sudo rpmdevtools rpmlint

RUN wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage \
    -O /usr/local/bin/linuxdeploy-appimage
RUN chmod +x /usr/local/bin/linuxdeploy-appimage

RUN wget https://github.com/linuxdeploy/linuxdeploy-plugin-native_packages/releases/download/continuous/linuxdeploy-plugin-native_packages-x86_64.AppImage \
    -O /usr/local/bin/native_packages-appimage
RUN chmod +x /usr/local/bin/native_packages-appimage

COPY linuxdeploy* /usr/local/bin
RUN chmod +x /usr/local/bin/linuxdeploy
RUN chmod +x /usr/local/bin/linuxdeploy-plugin-native_packages

ENV USERNAME=builder

RUN groupadd sudo
RUN useradd -ms /bin/bash $USERNAME
RUN usermod -aG sudo $USERNAME
RUN echo "$USERNAME ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USERNAME

USER $USERNAME

WORKDIR /builder

RUN sudo chown -R $USERNAME:$USERNAME /builder
