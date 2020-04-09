ARG GO_VER
ARG ALPINE_VER

# Go builder
FROM golang:${GO_VER} as builder

WORKDIR /opt

COPY ./go.mod ./go.mod
COPY ./go.sum ./go.sum

COPY ./cmd ./cmd

RUN go mod download && \
    go build -o ./build/bin/leveldbcmd ./cmd/leveldbcmd

# App container
FROM alpine:${ALPINE_VER}

COPY --from=builder /opt/build/bin/leveldbcmd /usr/local/bin/leveldbcmd 

