ARG REVISION
ARG CREATED
ARG VERSION
ARG GIT_REF="${VERSION}"

FROM golang:alpine AS builder

ARG GIT_REF
ARG VERSION
ENV VERSION="${VERSION}"
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GO111MODULE=on

WORKDIR /go/src/github.com/gohugoio/hugo

RUN apk add --no-cache \
    ca-certificates \
    git \
    musl-dev

RUN git clone --depth 1 --branch "${GIT_REF}" https://github.com/gohugoio/hugo.git \
    && cd hugo \
    && go install -ldflags '-s -w' \
    && if [$TARGETPLATFORM = "linux/amd64"]; then apk add --no-cache upx && upx --lzma --best /go/bin/hugo; fi

RUN addgroup hugo \
    && adduser -G hugo -s /bin/sh -D hugo

FROM scratch

COPY --from=builder /go/bin/hugo /usr/local/bin/hugo
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/ssl/certs /etc/ssl/certs

USER hugo
WORKDIR /site

ENTRYPOINT [ "/usr/local/bin/hugo" ]

LABEL org.opencontainers.image.title="hugo" \
    org.opencontainers.image.description="hugo in Docker" \ 
    org.opencontainers.image.source="${SOURCE}" \
    org.opencontainers.image.revision="${REVISION}" \
    org.opencontainers.image.created="${CREATED}" \
    org.opencontainers.image.version="${VERSION}"
