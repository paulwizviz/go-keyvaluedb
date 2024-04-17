ARG GO_VER
ARG OS_VER

# Go builder
FROM golang:${GO_VER} as builder

WORKDIR /opt

COPY ./go.mod ./go.mod
COPY ./go.sum ./go.sum

COPY ./cmd ./cmd

RUN go mod download && \
    go build -o ./build/bin/badgerdb ./cmd/badgerdb/cli

# App container
FROM ${OS_VER}

COPY --from=builder /opt/build/bin/badgerdb /usr/local/bin/badgerdb
RUN mkdir -p /opt/tmp/badgerdb