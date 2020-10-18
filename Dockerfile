FROM golang:1.12-alpine AS builder

# enable Go modules support
ENV GO111MODULE=on

WORKDIR /Users/zhaohang/Local/tinyProject

# manage dependencies
COPY go.mod .
COPY go.sum .
RUN go mod download

COPY cmd cmd
RUN CGO_ENABLED=0 GOOS=linux go build -a -o /tinyProject cmd/main.go

FROM alpine:3.9
RUN apk --no-cache add ca-certificates
COPY --from=builder /tinyProject /bin
CMD ["/bin/tinyProject"]
