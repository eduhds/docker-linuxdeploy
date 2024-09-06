# docker-linuxdeploy

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

Easy build AppImage, RPM and DEB packages with [linuxdeploy](https://github.com/linuxdeploy/linuxdeploy) on docker.

## Usage

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
docker run --rm -v $(pwd):/builder eduhds/linuxdeploy-rpm bash -c "
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
