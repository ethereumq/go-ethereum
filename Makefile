# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: GetHQ android ios gethq-cross swarm evm all test clean
.PHONY: gethq-linux gethq-linux-386 gethq-linux-amd64 gethq-linux-mips64 gethq-linux-mips64le
.PHONY: gethq-linux-arm gethq-linux-arm-5 gethq-linux-arm-6 gethq-linux-arm-7 gethq-linux-arm64
.PHONY: gethq-darwin gethq-darwin-386 gethq-darwin-amd64
.PHONY: gethq-windows gethq-windows-386 gethq-windows-amd64

GOBIN = $(shell pwd)/build/bin
GO ?= latest

geth:
	build/env.sh go run build/ci.go install ./cmd/gethq
	@echo "Done building."
	@echo "Run \"$(GOBIN)/gethq\" to launch gethq."

swarm:
	build/env.sh go run build/ci.go install ./cmd/swarm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/swarm\" to launch swarm."

all:
	build/env.sh go run build/ci.go install

android:
	build/env.sh go run build/ci.go aar --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/geth.aar\" to use the library."

ios:
	build/env.sh go run build/ci.go xcode --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/Geth.framework\" to use the library."

test: all
	build/env.sh go run build/ci.go test

clean:
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# The devtools target installs tools required for 'go generate'.
# You need to put $GOBIN (or $GOPATH/bin) in your PATH to use 'go generate'.

devtools:
	env GOBIN= go get -u golang.org/x/tools/cmd/stringer
	env GOBIN= go get -u github.com/jteeuwen/go-bindata/go-bindata
	env GOBIN= go get -u github.com/fjl/gencodec
	env GOBIN= go install ./cmd/abigen

# Cross Compilation Targets (xgo)

gethq-cross: gethq-linux gethq-darwin gethq-windows gethq-android gethq-ios
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/gethq-*

gethq-linux: gethq-linux-386 gethq-linux-amd64 gethq-linux-arm gethq-linux-mips64 gethq-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/gethq-linux-*

gethq-linux-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/386 -v ./cmd/gethq
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/gethq-linux-* | grep 386

gethq-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/gethq
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gethq-linux-* | grep amd64

gethq-linux-arm: gethq-linux-arm-5 gethq-linux-arm-6 gethq-linux-arm-7 gethq-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -ld $(GOBIN)/gethq-linux-* | grep arm

gethq-linux-arm-5:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-5 -v ./cmd/gethq
	@echo "Linux ARMv5 cross compilation done:"
	@ls -ld $(GOBIN)/gethq-linux-* | grep arm-5

gethq-linux-arm-6:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-6 -v ./cmd/gethq
	@echo "Linux ARMv6 cross compilation done:"
	@ls -ld $(GOBIN)/gethq-linux-* | grep arm-6

gethq-linux-arm-7:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-7 -v ./cmd/gethq
	@echo "Linux ARMv7 cross compilation done:"
	@ls -ld $(GOBIN)/gethq-linux-* | grep arm-7

gethq-linux-arm64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm64 -v ./cmd/gethq
	@echo "Linux ARM64 cross compilation done:"
	@ls -ld $(GOBIN)/gethq-linux-* | grep arm64

gethq-linux-mips:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips --ldflags '-extldflags "-static"' -v ./cmd/gethq
	@echo "Linux MIPS cross compilation done:"
	@ls -ld $(GOBIN)/gethq-linux-* | grep mips

gethq-linux-mipsle:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mipsle --ldflags '-extldflags "-static"' -v ./cmd/gethq
	@echo "Linux MIPSle cross compilation done:"
	@ls -ld $(GOBIN)/gethq-linux-* | grep mipsle

gethq-linux-mips64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64 --ldflags '-extldflags "-static"' -v ./cmd/gethq
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/gethq-linux-* | grep mips64

gethq-linux-mips64le:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64le --ldflags '-extldflags "-static"' -v ./cmd/gethq
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/gethq-linux-* | grep mips64le

gethq-darwin: gethq-darwin-386 gethq-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/gethq-darwin-*

gethq-darwin-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/386 -v ./cmd/gethq
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/gethq-darwin-* | grep 386

gethq-darwin-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/amd64 -v ./cmd/gethq
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gethq-darwin-* | grep amd64

gethq-windows: gethq-windows-386 gethq-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/gethq-windows-*

gethq-windows-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/386 -v ./cmd/gethq
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/gethq-windows-* | grep 386

gethq-windows-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/gethq
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gethq-windows-* | grep amd64
