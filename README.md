# gccb: getcams - container based control code
USAGE: (facilitated via Makefile)

Update specific config*, cam_access and cam_param files as needed
make all
	docker build -t gccb .
	docker run --rm -it -v /home/ghidl/k8/root/Data:/Data gccb bash
OR
	docker-compose up 

Monitor via 
make exec
	docker ps (to get  gccb hash ID)
	docker exec -it $ID /bin/bash

Upload image for remote execution 
make push
	docker login -u ghidley
	docker tag gccb ghidley/gccb
	docker push ghidley/gccb

On remote server execute via
make pull
	docker login -u ghidley
	docker run --rm -it ghidley/gccb bash

DEVELOPMENT NOTES:

gccb is the container based version of the getcams system and uses the getcams code base
gccb source master at https://github.com/ghidley/gccb and also backed up to c1:~ghidley/bu/gccb
getcams code base master at https://github.com/ghidley/getcams and also backed up to c1:~ghidley/bu/getcams

getcams runs on c0:~hpwren/bin/getcams and c5:~hpwren/bin/getcams ("sourced" from ~c[05]:ghidley/getcams)
gccb runs on T5600 sourced from T5600:~ghidley/k8/gccb
Getcams base maintained to be compatible with gccb operations, base cloned or copied into container
gccb extends base by updating key config files after getcams copy/clone (see Dockerfile)

Workflow --
	c0: Update getcams source as needed, then commit and push to github
	T5600: Fetch latest getcams code base
	make clone
		rm -rf getcams ; git clone --single-branch https://github.com/ghidley/getcams.git
	T5600: Update gccb source
	Test via "make all"
		docker build -t gccb .
		docker run --rm -it -v /home/ghidl/k8/root/Data:/Data gccb bash
			OR
		docker-compose up 
	When complete, commit and push to github
	Prior to remote execution, update image via 
	 docker push ghidley/gccb









