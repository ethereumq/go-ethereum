# Build gethq in a stock Go builder container
FROM golang:1.9-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers

ADD . /go-ethereumq
RUN cd /go-ethereumq && make gethq

# Pull gethq into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder /go-ethereumq/build/bin/gethq /usr/local/bin/

EXPOSE 9545 9546 40303 40303/udp 40304/udp
ENTRYPOINT ["gethq"]
