# FROM golang:1.17
FROM ubuntu:20.04

WORKDIR /app


# FROM docker-horizon-core repo
ENV STELLAR_CORE_VERSION 17.4.0-680.c5f6349.focal
ENV HORIZON_VERSION 2.8.1-140

EXPOSE 5432
EXPOSE 8000
EXPOSE 6060
EXPOSE 11625
EXPOSE 11626

ADD dependencies /app
RUN ["chmod", "+x", "/app/dependencies"]
RUN /app/dependencies

ADD install /app
RUN ["chmod", "+x", "/app/install"]
RUN /app/install

RUN ["mkdir", "-p", "/opt/stellar"]
RUN ["touch", "/opt/stellar/.docker-ephemeral"]

RUN ["ln", "-s", "/opt/stellar", "/stellar"]
RUN ["ln", "-s", "/opt/stellar/core/etc/stellar-core.cfg", "/stellar-core.cfg"]
RUN ["ln", "-s", "/opt/stellar/horizon/etc/horizon.env", "/horizon.env"]
ADD common /opt/stellar-default/common
ADD pubnet /opt/stellar-default/pubnet
ADD testnet /opt/stellar-default/testnet
ADD standalone /opt/stellar-default/standalone
# END FROM

# GO stuff
COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY *.go ./
RUN go build -o /alec-test-go

ADD start /app
RUN ["chmod", "+x", "/app/start"]
# CMD ["/app/start"]

RUN /app/start

CMD ["/alec-test-go"]

