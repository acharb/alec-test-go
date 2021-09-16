FROM golang:1.17

WORKDIR /app

COPY go.mod ./
COPY go.sum ./

RUN go mod download

COPY *.go ./

RUN go build -o /alec-test-go

RUN adduser alec


ADD dependencies /app
RUN ["chmod", "+x", "/app/dependencies"]
RUN /app/dependencies

ADD start /app
RUN ["chmod", "+x", "/app/start"]
CMD ["/app/start"]


# CMD ["/alec-test-go"]

