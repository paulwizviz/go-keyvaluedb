ARG GO_VER
ARG OS_VER

# LevelDB builder
FROM alpine:${OS_VER} as dbbuilder

WORKDIR /opt

RUN apk update && \
    apk upgrade && \
    apk --no-cache add git cmake make g++ && \
    git clone --depth 1 --branch v1.20 https://github.com/google/leveldb.git && \
    cd leveldb && make 

# Go builder
FROM golang:${GO_VER}-alpine${OS_VER} as gobuilder

WORKDIR /opt

COPY ./go.mod ./go.mod
COPY ./go.sum ./go.sum

COPY ./cmd ./cmd

RUN go mod download && \
    go build -o ./build/bin/leveldbcmd ./cmd/leveldbcmd

# App container
FROM alpine:${OS_VER}

COPY --from=gobuilder /opt/build/bin/leveldbcmd /usr/local/bin/leveldbcmd
COPY --from=dbbuilder /opt/leveldb/out-static/lib* /usr/lib/
COPY --from=dbbuilder /opt/leveldb/out-shared/libleveldb.so.1.20 /usr/lib
COPY --from=dbbuilder /opt/leveldb/include /usr/include

RUN cd /usr/lib && \
    ln -s libleveldb.so.1.20 libleveldb.so && \
    ln -s libleveldb.so.1.20 libleveldb.so.1

# FROM alpine:${OS_VER}

# COPY --from=gobuilder /opt/build/bin/leveldbcmd /usr/local/bin/leveldbcmd

# RUN apk update && apk upgrade && \
#     apk --no-cache add leveldb-dev 