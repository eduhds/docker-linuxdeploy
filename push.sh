#!/bin/bash

set -e

docker tag eduhds/linuxdeploy-appimage:latest eduhds/linuxdeploy-appimage:latest
docker push eduhds/linuxdeploy-appimage:latest

docker tag eduhds/linuxdeploy-deb:latest eduhds/linuxdeploy-deb:latest
docker push eduhds/linuxdeploy-deb:latest

docker tag eduhds/linuxdeploy-rpm:latest eduhds/linuxdeploy-rpm:latest
docker push eduhds/linuxdeploy-rpm:latest
