.PHONY: all build mini mini2


all: build

build:
	docker build -t iperf:latest .

full:
	docker build -f=Dockerfile.full -t iperf:full .

mini:
	docker build -f=Dockerfile.mini -t iperf:mini .
