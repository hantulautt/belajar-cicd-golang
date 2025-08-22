# syntax=docker/dockerfile:1
FROM golang:1.22-alpine AS builder

WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . .
RUN go build -o app

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/app .
EXPOSE 3000
CMD ["./app"]