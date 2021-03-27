# Makefile for container based getcams system

all: Dockerfile
	docker build -t gccb .
	docker run --rm -it -v /home/ghidl/k8/root/Data:/Data gccb bash

