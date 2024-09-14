# docker-linuxdeploy

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

Easy build AppImage, RPM and DEB packages with [linuxdeploy](https://github.com/linuxdeploy/linuxdeploy) on docker.

## Images

| Image                | Base System                                                                                           | Targets       |
| -------------------- | ----------------------------------------------------------------------------------------------------- | ------------- |
| linuxdeploy-appimage | ![Fedora](https://img.shields.io/badge/Fedora-294172?style=for-the-badge&logo=fedora&logoColor=white) | AppImage      |
| linuxdeploy-rpm      | ![Fedora](https://img.shields.io/badge/Fedora-294172?style=for-the-badge&logo=fedora&logoColor=white) | RPM, AppImage |
| linuxdeploy-deb      | ![Debian](https://img.shields.io/badge/Debian-D70A53?style=for-the-badge&logo=debian&logoColor=white) | DEB, AppImage |

> `linuxdeploy-appimage` is just for convenience since `linuxdeploy-rpm` and `linuxdeploy-deb` can also build AppImages.

## Basic Usage

### Docker run

If your executable don't require additional libraries and already built:

```sh
# .AppImage
docker run --rm -v $(pwd):/builder eduhds/linuxdeploy-appimage linuxdeploy \
    --appdir /path/to/AppDir \
    --executable /path/to/executable \
    --icon-file /path/to/icon-file \
    --desktop-file /path/to/desktop-file \
    --output appimage

# .rpm
docker run --rm -v $(pwd):/builder eduhds/linuxdeploy-rpm bash -c "
    LDNP_BUILD=rpm LINUXDEPLOY_OUTPUT_APP_NAME=app_name LINUXDEPLOY_OUTPUT_VERSION=app_version linuxdeploy \
    --appdir /path/to/AppDir \
    --executable /path/to/executable \
    --icon-file /path/to/icon-file \
    --desktop-file /path/to/desktop-file \
    --output native_packages"

# .deb
docker run --rm -v $(pwd):/builder eduhds/linuxdeploy-deb bash -c "
    LDNP_BUILD=deb LINUXDEPLOY_OUTPUT_APP_NAME=app_name LINUXDEPLOY_OUTPUT_VERSION=app_version linuxdeploy \
    --appdir /path/to/AppDir \
    --executable /path/to/executable \
    --icon-file /path/to/icon-file \
    --desktop-file /path/to/desktop-file \
    --output native_packages"
```

### Dockerfile

If your executable must be linked with some additional library, build it in your own image:

1 - Create Dockerfile

```dockerfile
# Choose a image (-appimage, -deb, -rpm)
FROM eduhds/linuxdeploy-deb:latest

# Install dependencies to build your executable (dnf instead apt if applicable)
RUN sudo apt update -y
RUN sudo apt install -y ...

# Build your executable
# ...
```

2 - Build custom image

```sh
docker build -t my-custom-image .
```

3 - Use your custom image to package

```sh
docker run --rm -v $(pwd):/builder my-custom-image bash -c "
    LDNP_BUILD=deb LINUXDEPLOY_OUTPUT_APP_NAME=app_name LINUXDEPLOY_OUTPUT_VERSION=app_version linuxdeploy \
    --appdir /path/to/AppDir \
    --executable /path/to/executable \
    --icon-file /path/to/icon-file \
    --desktop-file /path/to/desktop-file \
    --output native_packages"
```

## Development

### Build

```sh
docker build -f appimage.Dockerfile -t eduhds/linuxdeploy-appimage .
docker build -f deb.Dockerfile -t eduhds/linuxdeploy-deb .
docker build -f rpm.Dockerfile -t eduhds/linuxdeploy-rpm .
```

## Credits

- [linuxdeploy/linuxdeploy](https://github.com/linuxdeploy/linuxdeploy)
- [linuxdeploy/linuxdeploy-plugin-native_packages](https://github.com/linuxdeploy/linuxdeploy-plugin-native_packages)
