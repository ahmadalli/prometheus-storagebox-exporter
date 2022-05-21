# syntax=docker/dockerfile:1
FROM golang:1.16 as build
WORKDIR /src/
COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY *.go ./
RUN go build -o prometheus-storagebox-exporter

FROM alpine:latest
WORKDIR /app/
EXPOSE 9509

COPY --from=build /src/prometheus-storagebox-exporter ./

ENTRYPOINT ["./prometheus-storagebox-exporter"]
