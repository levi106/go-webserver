FROM golang as builder

ENV GO111MODULE=on

WORKDIR /app

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build

FROM alpine
COPY --from=builder /app/go-webserver /app/
EXPOSE 80
ENTRYPOINT ["/app/go-webserver"]
