.PHONY: build cluster test

default: build

build:
	go build -o bin/swarm    github.com/ethereumq/go-ethereumq/cmd/swarm
	go build -o bin/geth     github.com/ethereumq/go-ethereumq/cmd/gethq
	go build -o bin/bootnode github.com/ethereumq/go-ethereumq/cmd/bootnode

cluster: build
	scripts/boot-cluster.sh

test:
	go test -v github.com/ethereumq/go-ethereumq/swarm/...
