#!/bin/sh

VERSION=$(grep -e "ARG HUGO_VERSION=" stable/Dockerfile)
VERSION=${VERSION#ARG HUGO_VERSION=\"}
VERSION=${VERSION%\"}
echo "Tagging version ${VERSION}"
docker tag "${DOCKER_USERNAME}/hugo:latest" "${DOCKER_USERNAME}/hugo:${VERSION}"
