ARG HUGO_VERSION="master"

FROM golang:1.12-alpine AS builder

ARG HUGO_VERSION
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GO111MODULE=on
ENV HUGO_VERSION "${HUGO_VERSION}"

WORKDIR /go/src/github.com/gohugoio/hugo

RUN apk add --no-cache \
    ca-certificates \
    git \
    musl-dev

RUN git clone --depth 1 --branch "${HUGO_VERSION}" https://github.com/gohugoio/hugo.git \
    && cd hugo \
    && go install -ldflags '-s -w'

FROM alpine:edge

ARG HUGO_VERSION

COPY --from=builder /go/bin/hugo /usr/local/bin/hugo

RUN apk upgrade && apk --no-cache add \
    ca-certificates \
    && addgroup hugo \
    && adduser -G hugo -s /bin/sh -D hugo

USER hugo
WORKDIR /site

ENTRYPOINT [ "hugo" ]

LABEL org.opencontainers.image.title="hugo" \
    org.opencontainers.image.description="hugo in Docker" \  
    org.opencontainers.image.url="https://github.com/westonsteimel/docker-hugo" \ 
    org.opencontainers.image.source="https://github.com/westonsteimel/docker-hugo" \
    org.opencontainers.image.version="${HUGO_VERSION}"
