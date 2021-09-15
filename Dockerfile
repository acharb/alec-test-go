FROM golang:1.17

WORKDIR /app

COPY go.mod ./
COPY go.sum ./

RUN go mod download

COPY *.go ./

RUN go build -o /alec-test-go

CMD ["/alec-test-go"]