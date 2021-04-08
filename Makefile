# Makefile for container based getcams system

ALLFILES=Makefile* cam_* config* Dockerfile README.md hosts-cb
#ALLFILES=Makefile cam_access config_getcams_vars-cb Dockerfile README.md cam_params-cb config_runcam_vars-cb  hosts-cb


all: Dockerfile
	docker build -t gccb .
	-docker run --rm -it -v /home/ghidl/k8/root/Data:/Data gccb bash

build:
	docker build -t gccb .

rebuild: Dockerfile
	docker build --no-cache -t gccb .
	-docker run --rm -it -v /home/ghidl/k8/root/Data:/Data gccb bash

clone:
	rm -rf getcams ; git clone --single-branch https://github.com/ghidley/getcams.git

purge:
	docker system prune -af
	docker image prune -af

push:
	docker login -u ghidley
	docker tag gccb ghidley/gccb
	docker push ghidley/gccb

pull:
	docker login -u ghidley
	docker run --rm -it ghidley/gccb bash

backup:
	scp  $(ALLFILES) ghidley@c1.hpwren.ucsd.edu:bu/gccb

exec:
	#docker exec -it $(docker ps -q) /bin/bash
	-docker exec -it $(shell docker ps -q)  /bin/bash

run:
	-docker run --rm -it -v /home/ghidl/k8/root/Data:/Data gccb bash 

