# Makefile for container based getcams system
# v.041121
ALLFILES=Makefile* cam_* config* Dockerfile README.md hosts-cb compose.yaml docker-entrypoint.sh  entry_commands.sh
#ALLFILES=Makefile cam_access compose.yaml config_getcams_vars-cb Dockerfile README.md cam_params-cb config_runcam_vars-cb  hosts-cb

#Build and run via docker
all: Dockerfile
	docker build -t gccb .
	-docker run --rm -it -d -v /home/ghidl/k8/root/Data:/Data gccb bash

test: 
	docker build -t gccb .
	docker run --rm -it -d -v /home/ghidl/k8/root/Data:/Data gccb bash

build:
	docker build -t gccb .

rebuild: Dockerfile
	rm -rf getcams ; git clone --single-branch https://github.com/ghidley/getcams.git
	docker build --no-cache -t gccb .
	-docker run --rm -it -d -v /home/ghidl/k8/root/Data:/Data gccb bash

run:
	-docker run --rm -it -d -v /home/ghidl/k8/root/Data:/Data gccb bash 

# Get shell into running getcams container
exec:
	@#docker exec -it $(shell docker ps -q)  /bin/bash
	ID=$(shell docker ps | grep gccb | head -1 | awk '{print $$1 }'); docker exec -it $$ID /bin/bash

kill:
	-ID=$(shell docker ps | grep gccb | head -1 | awk '{print $$1 }'); docker kill $$ID 

# Docker-compose commands
Dc:
	docker-compose up

Dcb:
	docker-compose up --build

Dcs:
	docker-compose stop

Dcrm:
	docker-compose rm -sf

# Update to latest getcams base code from github (make sure current getcams source has been pushed to github)
clone:
	rm -rf getcams ; git clone --single-branch https://github.com/ghidley/getcams.git

# If all else fails, get rid of all container and image artifacts (make purge rebuild)
purge:
	docker system prune -af
	docker image prune -af

# Support remote execution via docker hub stored image[s]
push:
	docker login -u ghidley
	docker tag gccb ghidley/gccb
	docker push ghidley/gccb

pull:
	docker login -u ghidley
	docker run --rm -it ghidley/gccb bash

backup:
	scp  $(ALLFILES) ghidley@c1.hpwren.ucsd.edu:bu/gccb

git: #Add, commit, and push current release
	git status
	@( read -p "add . !? [y/N]: " sure && case "$$sure" in [yY]) true;; *) false;; esac )
	git add .
	@( read -p "commit !? [y/N]: " sure && case "$$sure" in [yY]) true;; *) false;; esac )
	git commit
	@( read -p "push !? [y/N]: " sure && case "$$sure" in [yY]) true;; *) false;; esac )
	git push origin master
	date

